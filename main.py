from  flask import Flask, render_template, request
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
    # just a test route
    message = "Welcome !"
    return render_template('entry.html',
                            title=message)

@app.route('/jinja_test')
def jinja_test():
    return render_template('jinja_test.html')

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
    new_order_data = (
                    request.form['customer'],
                    request.form['destination_address'],
                    int(request.form['courier']),
                    datetime.now(timezone(timedelta(0))),
                    request.form['email'],
                    )

    raw_items = json.loads(request.form['hid_items_to_submit'])
    print(new_order_data)
    print(raw_items)

    with UseDatabase(app.config['dbconfig']) as cursor:
        sql_insert_new_order = """
            INSERT INTO `order` (
                recepient_name,
                destination_address,
                courier,
                order_datetime,
                email
            )
            VALUES(%s, %s, %s, %s, %s)
            """
        cursor.execute(sql_insert_new_order, new_order_data)
        new_order_no = cursor.lastrowid

        print(f"new_order_no:{new_order_no}")

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

        print(f"prepared_items:\n{prepared_items}")

        sql_insert_new_order_sku_details = """
            INSERT INTO `order_sku` (
                order_id,
                sku,
                quantity,
                orderline_price
            )
            VALUES(%s, %s, %s, %s)
            """
        cursor.executemany(sql_insert_new_order_sku_details, prepared_items)
        print(f"rowcount:{cursor.rowcount}\n"
                f"statement:{cursor.statement}\n"
                f"with_rows:{cursor.with_rows}\n"
                f"fetchall result:\n{cursor.fetchall()}")

    # message = (f"Your order:"
    #             f"full name: {request.form['customer']}"
    #             f"destination_address: {request.form['destination_address']}"
    #             f"email: {request.form['email']}"
    #             f"courier: {request.form['courier']}"
    #             f"sku_qty_dict: {request.form['sku_qty_dict']}")

    message = "some message"
    return render_template('entry.html',
                            message=message)

if __name__ == '__main__':
    app.run(debug=True)
