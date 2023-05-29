from  flask import Flask, render_template, request, jsonify
from dotenv import load_dotenv
import os
from dbc import UseDatabase
import json
from datetime import datetime, timezone, timedelta

load_dotenv()

app = Flask(__name__)
app.secret_key = os.environ['FLASK_SECRET_KEY']
app.config['dbconfig'] = {'host': os.environ['DB_HOST'],
                            'user': os.environ['DB_USER'],
                            'password': os.environ['DB_PASSWORD'],
                            'database': os.environ['DB_NAME']}

@app.route('/')
def test() -> str:
    # entry page
    return render_template('entry.html',
                            message='Welcome !')

@app.route('/all_items')
def get_all_items():
    # retreive all items
    try:
        with UseDatabase(app.config['dbconfig']) as cursor:
            _SQL = """
                    SELECT
                        i.sku, i.name, i.description, i.unit_price, d.division_name
                    FROM
                        `item` i,
                        `product_division` d
                    WHERE
                        i.division = d.id
                    """
            cursor.execute(_SQL)
            result = cursor.fetchall()
            column_names = ('sku', 'name', 'description', 'unit_price', 'division_name')
            return render_template('all_items.html',
                                    title='list of all items',
                                    items=result,
                                    column_names=column_names)
    except Exception as err:
        print('Something went wrong', str(err))

@app.route('/order_form')
def get_order_page():
    # return a page to create and submit a new order
    try:
        with UseDatabase(app.config['dbconfig']) as cursor:
            _SQL = """
                    SELECT
                        courier_id, name
                    FROM
                        `courier`
                    """
            cursor.execute(_SQL)
            result = cursor.fetchall()
            return render_template('order_form.html',
                                    couriers=result,
                                    title="submit your order")
    except Exception as err:
        print('Something went wrong', str(err))

@app.route('/submit_order', methods=['POST', 'GET'])
def submit_order():
    # insert new order into db
    raw_items = json.loads(request.form['hid_items_to_submit'])
    order_sum = 0

    for item in  raw_items:
        order_sum += item['price'] * item['qty']

    new_order_data = (
                    request.form['customer'],
                    request.form['destination_address'],
                    int(request.form['courier']),
                    datetime.now(timezone(timedelta(0))),
                    request.form['email'],
                    order_sum
                    )

    try:
        with UseDatabase(app.config['dbconfig']) as cursor:
            sql_insert_new_order = """
                INSERT INTO `order` (
                    recepient_name,
                    destination_address,
                    courier,
                    order_datetime,
                    email,
                    order_sum
                )
                VALUES(%s, %s, %s, %s, %s, %s)
                """
            cursor.execute(sql_insert_new_order, new_order_data)
            new_order_no = cursor.lastrowid
    
            prepared_items = []
            for item in raw_items:
                prepared_items.append(
                    (
                        new_order_no,
                        item['sku'],
                        item['qty'],
                        item['price'] * item['qty'],
                    )
                )

            sql_insert_new_order_sku_details = """
                INSERT INTO `order_sku` (
                    order_id,
                    sku,
                    quantity,
                    item_sum
                )
                VALUES(%s, %s, %s, %s)
                """
            cursor.executemany(sql_insert_new_order_sku_details, prepared_items)
            message = "You've successfully submited the order."
    except Exception as err:
        print(err)
        message = f"Oops! Something went wrong. Error:<br>{str(err)}"

    return render_template('entry.html',
                            message=message)

@app.route('/staff_only/control_panel')
def show_control_panel():
    #
    return render_template('/staff_only/control_panel.html')

@app.route('/staff_only/all_orders')
def get_all_orders():
    #
    sql_get_all_orders = """
        SELECT
	        order_id,
	        recepient_name,
	        destination_address,
            if(is_shipped, 'Y', 'N') as is_shipped,
	        c.name as courier,
	        order_datetime,
            shipped_datetime,
	        email,
            status,
            order_sum
        FROM
            `order` o, `courier` c
        WHERE
            o.courier = c.courier_id
        ORDER BY order_id ASC
    """
    try:
        with UseDatabase(app.config['dbconfig']) as cursor:
            cursor.execute(sql_get_all_orders)
            all_orders = cursor.fetchall()
            order_column_names = cursor.column_names
    except Exception as err:
        print(err)

    return render_template('/staff_only/all_orders.html',
                            all_orders=all_orders,
                            order_column_names=order_column_names)

@app.route('/staff_only/waiting_orders')
def get_wating_orders():
    #
    sql_get_waiting_orders = """
        SELECT
	        order_id,
	        recepient_name,
	        destination_address,
	        c.name as courier,
	        order_datetime,
	        email,
            order_sum
        FROM
            `order` o, `courier` c
        WHERE
            o.courier = c.courier_id
            and status = 'waiting'
        ORDER BY order_id ASC
    """
    sql_orders_sku_details = """
        SELECT
            os.order_id,
            os.sku,
            os.quantity,
            i.unit_price,
            os.item_sum
        FROM
            `order` o JOIN `order_sku` os
            ON o.order_id = os.order_id
            AND o.status = 'waiting'
            JOIN `item` i
            ON os.sku = i.sku
    """
    try:
        with UseDatabase(app.config['dbconfig']) as cursor:
            cursor.execute(sql_get_waiting_orders)
            waiting_orders = cursor.fetchall()
            order_column_names = cursor.column_names
            if (len(waiting_orders) == 1 and len(waiting_orders[0]) == 0):
                return render_template('/staff_only/waiting_orders.html',
                                        there_are_waiting_orders=False)
            cursor.execute(sql_orders_sku_details)
            orders_sku_details = cursor.fetchall()
            sku_details_column_names = cursor.column_names
    except Exception as err:
        print(err)

    return render_template('/staff_only/waiting_orders.html',
                            there_are_waiting_orders=True,
                            waiting_orders=waiting_orders,
                            orders_sku_details=orders_sku_details,
                            order_column_names=order_column_names,
                            sku_details_column_names=sku_details_column_names)

@app.route('/staff_only/statistic')
def get_statistic():
    #
    sql_orders_total_count = """
        SELECT
            count(order_id) as all_orders_count
        FROM `order`
    """

    sql_orders_total_sum = """
        SELECT
	        round(sum(order_sum), 4) as all_orders_sum
        FROM `order`
    """

    sql_orders_shipped_count = """
        SELECT
            count(order_id) as shipped_orders_count
        FROM `order`
        WHERE is_shipped is true
    """

    sql_orders_not_shipped_count = """
        SELECT
            count(order_id) as not_shipped_orders_count
        FROM `order`
        WHERE is_shipped is false
    """

    sql_top5_customers = """
        SELECT
        	orders_per_customer.recepient_name,
        	orders_per_customer.orders_count,
            sum_per_customer.orders_sum,
            dense_rank() over(order by orders_per_customer.orders_count desc,
        						sum_per_customer.orders_sum desc) as customer_rank
        FROM
        	(SELECT
        		recepient_name,
        		count(order_id) as orders_count
        	FROM `order`
        	GROUP BY recepient_name
        	) as orders_per_customer
            JOIN
            (SELECT
        		recepient_name,
                round(sum(order_sum), 4) as orders_sum
            FROM `order`
            GROUP BY recepient_name
            ) as sum_per_customer
            ON orders_per_customer.recepient_name = sum_per_customer.recepient_name
        ORDER BY customer_rank asc
        LIMIT 5
    """

    metrics = {}

    try:
        with UseDatabase(app.config['dbconfig']) as cursor:
            cursor.execute(sql_orders_total_count)
            metrics['orders_total_count'] = cursor.fetchall()[0][0]
            cursor.execute(sql_orders_total_sum)
            metrics['orders_total_sum'] = cursor.fetchall()[0][0]
            cursor.execute(sql_orders_shipped_count)
            metrics['orders_shipped_count'] = cursor.fetchall()[0][0]
            cursor.execute(sql_orders_not_shipped_count)
            metrics['orders_not_shipped_count'] = cursor.fetchall()[0][0]
            cursor.execute(sql_top5_customers)
            top5_customers = cursor.fetchall()
            top5_columns = cursor.column_names
    except Exception as err:
        print(err)

    return render_template('staff_only/statistic.html',
                            metrics=metrics,
                            top5_customers=top5_customers,
                            top5_columns=top5_columns)

@app.route('/staff_only/order_details', methods=['POST'])
def get_order_details():
    #
    response = {}
    sql_get_order_details = """
        SELECT
            os.order_id,
            os.sku,
            i.name,
            pd.division_name as division,
            i.unit_price,
            os.quantity,
            os.item_sum
        FROM
            `order_sku` os, `item` i, `product_division` pd
        WHERE
            os.sku = i.sku
            and os.order_id = %s
            and i.division = pd.id
    """
    try:
        with UseDatabase(app.config['dbconfig']) as cursor:
            cursor.execute(sql_get_order_details,
                            (request.json['order_id'],))
            order_details = cursor.fetchall()
            response['update-status'] = "ok"
            response['column_names'] = cursor.column_names
            response['order_details'] = json.dumps(order_details)
    except Exception as err:
        print(err)
        response['update-status'] = "error"
        response['error-message'] = str(err)

    return jsonify(response)

@app.route('/staff_only/approved_orders')
def get_approved_orders():
    #
    sql_get_approved_orders = """
        SELECT
	        order_id,
	        recepient_name,
	        destination_address,
            if(is_shipped, 'Y', 'N') as is_shipped,
	        c.name as courier,
	        order_datetime,
	        email,
            status,
            order_sum
        FROM
            `order` o, `courier` c
        WHERE
            o.courier = c.courier_id
            and status = 'approved'
            and is_shipped = 0
        ORDER BY order_id ASC
    """
    try:
        with UseDatabase(app.config['dbconfig']) as cursor:
            cursor.execute(sql_get_approved_orders)
            approved_orders = cursor.fetchall()
            if (len(approved_orders) == 1 and len(approved_orders[0]) == 0):
                return render_template('/staff_only/approved_orders.html',
                                        there_are_approved_orders=False)
    except Exception as err:
        print(err)
    order_column_names = cursor.column_names
    return render_template('/staff_only/approved_orders.html',
                            there_are_approved_orders=True,
                            approved_orders=approved_orders,
                            order_column_names=order_column_names)

@app.route('/staff_only/update_order_status', methods=['POST'])
def update_order_status():
    #
    response = {}

    if request.json['order_status'] == 'shipped':
        sql_update_order_status = """
        UPDATE `order`
        SET is_shipped = %s,
            shipped_datetime = %s
        WHERE order_id = %s
        """
        update_params = (True,
                        datetime.fromtimestamp(request.json['ship_datetime'],
                                                timezone(timedelta(0))),
                        request.json['order_id'],)
    elif request.json['order_status'] == 'approved':
        sql_update_order_status = """
            UPDATE `order`
            SET status = %s
            WHERE order_id = %s
        """
        update_params = (request.json['order_status'],
                        request.json['order_id'],)

    try:
        with UseDatabase(app.config['dbconfig']) as cursor:
            cursor.execute(sql_update_order_status,
                            update_params)
            response['update-status'] = "ok"
    except Exception as err:
        print(err)
        response['update-status'] = "error"
        response['error-message'] = str(err)

    return jsonify(response)

if __name__ == '__main__':
    app.run(debug=True)
