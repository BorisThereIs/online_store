from  flask import Flask, render_template, request
from dotenv import load_dotenv
import os
from dbc import UseDatabase
import json

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
    sku_qty = json.loads(request.form['sku_qty_dict'])

    message = (f"Your order:"
                f"full name: {request.form['customer']}"
                f"destination_address: {request.form['destination_address']}"
                f"email: {request.form['email']}"
                f"courier: {request.form['courier']}"
                f"sku_qty_dict: {request.form['sku_qty_dict']}")
    return render_template('entry.html',
                            message=message)

if __name__ == '__main__':
    app.run(debug=True)
