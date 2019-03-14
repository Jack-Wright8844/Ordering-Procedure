set feedback off
set echo off
set verify off
set heading off
spool c:/DBMS/ShippedSpool.txt

prompt
prompt ********* UPDATE SHIPPING ***********
prompt
accept vOrdnum  prompt 'Please enter the Order number: '
prompt
select 'Order Number: ', '&vOrdnum'
	from orders
	where order_ID = '&vOrdnum';

select 'Order Date: ', Order_Date 
	from orders
	where Order_ID = '&vOrdnum';

select 'Customer Number: ', Cust_ID
	from orders
	where orders.Order_ID = '&vOrdnum';


----------------------Customer Information---------------------


select'   '||initcap(clast)||','||Initcap(cfirst)
from orders,customers 
where order_ID = '&vOrdNum'
	and orders.Cust_ID = customers.CustID;

select cshipaddress
from orders, customers
where order_ID = '&vordnum'
	and Orders.Cust_ID = Customers.CustID;

select''||Initcap(Ccity)||',' ||Upper(Cstate)||','||Czip
from orders, Customers
where order_ID = '&vOrdnum'
	and Orders.Cust_ID = Customers.CustID;

select '   ('||Substr(Cphone,1,3)||')'||Substr(Cphone,4,3)||'-'||Substr(Cphone,-4)
from Orders, Customers
where Order_ID = '&vOrdnum'
	and Orders.Cust_ID = Customers.CustID;
prompt

--------------------------Product Information-------------------------------

select 'Item Number: ', ltrim(Product_ID)
from orders
where Order_ID = '&vordnum';

select 'Item Description: ', Product_Name
from orders, products
where Order_ID = '&vOrdnum'
	and orders.Product_ID = Products.Product_ID;

Select 'Unit Price: ','$'||Unit_Price
from orders 
where Order_ID = '&vOrdnum'

--------------------Warehouse Information-----------------------

prompt
select 'Shipping Warehouse: ', Warehouse_num
from orders
where order_ID = '&vOrdnum';

select initcap(Warehouse_Address)
from orders, warehouse
where Order_ID = '&vOrdnum'
	and orders.warehouse_num = warehouse.warehouse_num;


select Warehouse_City||','||warehouse_state||','||warehouse_zip
from orders, warehouse
where order_ID = '&vordnum'
	and orders.warehouse_Num = warehouse.warehouse_num;

select '    ('||Substr(PhoneNumber,1,3)||')'||Substr(PhoneNumber,4,3)||'-'||Substr(PhoneNumber,-4)
from orders, warehouse
where order_ID = '&vordnum'
and orders.warehouse_num = warehouse.warehouse_num
prompt


-------------------ACCEPTING----------------------
accept vShipDate prompt 'Please enter the ship date (mm/dd/yyyy):'

accept vShipqty prompt 'Please enter the shipping quantity:'




prompt
prompt **********************************************************
prompt

------------------UPDATES---------------------------
update orders
set Ship_Qty = '&vShipqty'
where Order_ID = '&vOrdnum';

update orders
set ship_amt = unit_price * '&vShipqty'
where order_ID = '&vOrdnum';

update orders
set ship_date = to_date('&vShipDate', 'mm/dd/yyyy')
where Order_ID = '&vOrdnum';

update orders
set Order_Status = 'Shipped'
where Order_ID = '&vOrdnum';

update Inventory
set Inventory_Quantity = Inventory_Quantity - '&vShipqty'
where Product_ID = (select Product_ID from orders where order_ID = '&vOrdNum')
	and Warehouse_num = (select Warehouse_Num from orders where order_ID = '&vOrdNum');

-----------------DISPLAY--------------------------------

select 'Order is now------> ', Order_Status
from orders
where order_ID = '&vOrdNum';

select 'Date Shipped: ', ship_date
from orders
where order_ID = '&vOrdnum';

select 'Quantity Shipped: ', Ship_Qty
from orders
where order_ID = '&vOrdnum';

select 'Amount Shipped: ','$'||ship_amt
from orders
where order_ID = '&vOrdnum';


commit;
set heading on



spool off