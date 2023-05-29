# online_store
## Overview
Flask based web app implemented as a test assignment. 
A goal is to implement a model of a simple online store with the following functionality:
- show all items available in store
- show a list of couriers available in store
- show a list of submited orders with details
- ability to create a new order
- mark an order as shipped
- show some statistic
  - total count of all orders
  - total sum of all orders
  - count of shipped and not shipped orders
  - top 5 the most frequent customers

Used stack:
- Python 3
- Flask
- MySQL

No ORM was involved to interract with a data base - just a plain SQL.

Tasks to do: 
- make code more object oriented. Create classes for main app entities (e.g. order, item, etc.)
- add comments
- add tests
- add logging
- check code in terms of pep8

## How to use app as a customer
Enter a default route ('localhost:5000/') -> go to a catalog ('/all_items') -> add one or more items to a cart and click "Order" button -> fill in a form and select a couerir on the next page ('/order_form') and click "submit order".

## How to use app as a staff
Enter a control panel ('/staff_only/control_panel') and click any section you want:
- "waiting orders" - list of orders with a "waiting" status which should be approved
- "all orders" - list of all submited orders with ability to show details
- "mark orders as shipped" - list of approved orders which can be marked as shipped
- "statistic" - page with a required statistic
- "catalog" - go back to a catalog

## Order flow
A new order appiers in db with status "waiting" after submitting the one on behalf of a customer. Then we can manipulate the order as a staff person through control panel: change the status to "approved" and then mark as "shipped".

## DB schema diagram

## Before running app ..
