set feedback off
set echo off
set verify off
set heading off

spool c:/DBMS/queryspool.txt

prompt *****SHOW ORDER DETAILS******
prompt
accept vOrdnum prompt 'Please enter the Order Number: ';

prompt
select 'Order Number: ', Order_ID
	from Orders
	where Order_ID = '&vOrdnum';
prompt
select 'Order Status: ', Order_Status
	from Orders
	where Order_ID = '&vOrdnum';
prompt
select 'Customer Number: ', Cust_ID
	from Orders
	where Order_ID = '&vOrdnum';
prompt
select Clast||','||Cfirst || chr(10) ||
	Cshipaddress || chr(10) ||
	Ccity||','||Cstate||' '||Czip|| chr(10) ||
	'('||substr(Cphone, 1, 3)||')'||substr(Cphone,4,3)||'-'||substr(Cphone,7)
	from customers
	where CustID = '&vCnum';
prompt
select 'Item Number: ', Product_ID
	from orders
	where Order_ID = '&vOrdnum';
prompt
select 'Item Description: ', Product_Name
	from products
	where Product_ID = '&vPnum';
prompt
select 'Unit Price: ','$'||Unit_Price
	from Orders
	where Order_ID = '&vOrdnum';
prompt
select 'Order Date: ', Order_date
	from orders
	where Order_ID = '&vOrdnum';
prompt
select 'Shipping Date: ', Ship_Date
	from orders
	where Order_ID = '&vOrdnum';
prompt
select 'Quantity Ordered: ',Order_Qty
	from orders
	where Order_ID = '&vOrdnum';
prompt
select 'Shipping Warehouse: ',Warehouse_Num
	from orders
	where Order_ID = '&vOrdnum';
prompt
select Warehouse_Address || chr(10) || 
	Warehouse_City||','||Warehouse_State||' ' ||Warehouse_Zip|| chr(10)||
	'('||substr(Warehouse_Phone, 1, 3)||')'||substr(Warehouse_Phone, 4, 3)||'-'||substr(Warehouse_Phone, 7)
	from warehouse
	where Warehouse_num = '&vWnum';

spool off