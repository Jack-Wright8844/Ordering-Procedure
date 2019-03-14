set feedback off
set echo off
set verify off
set heading off
spool C:/DBMS/ordertestspool.txt

prompt
prompt ****** PLACE AN ORDER ******
prompt
prompt Today's Date: 
select sysdate from dual;

accept vCnum prompt 'Enter the Customer Number: '; 

select 'Customer Name: ', Clast||', '||Cfirst 
	from customers
	where CustID = '&vCnum' ;
select 'Shipping Address: ',Cshipaddress 
	from customers
	where CustID = '&vCnum';
select 'City, State, Zip: ',Ccity||', '||Cstate||' '||Czip 
	from customers
	where CustID = '&vCnum';
select 'Phone:', '('||substr(Cphone, 1, 3)||')'||substr(Cphone, 4, 3)||'-'||substr(Cphone, 7)
	from customers
	where CustID = '&vCnum';

accept vPnum prompt 'Enter the Item Number: ';
select 'Item Number: ', Product_ID from products
	where Product_ID = '&vPnum';
select 'Item Description: ', Product_Name from products
	where Product_Name = '&vPnum';
select 'Unit Price: ', '$'||Unit_Price from products
	where Product_ID = '&vPnum';

accept vOrdqty prompt 'Enter the quantity ordered: ';

select 'Amount Ordered: ', '$'||p.Unit_Price * &vOrdqty total
	from products p
	where Product_ID = '&vPnum'; 
prompt
prompt
prompt

prompt Please choose from the following warehouses: ;
prompt
prompt
prompt
set heading on
select w.Warehouse_num, w.Warehouse_city, w.Warehouse_state, i.Inventory_Quantity
	from warehouse w, inventory i
	where W.Warehouse_num = i.Warehouse_Num	
	and i.Product_ID = '&vPnum';
prompt
prompt
accept vWnum prompt 'Enter the warehouse code: '; 
set heading off
prompt
prompt ******* ORDER STATUS: OPEN
prompt
select '***** Order number is ------>', maxnum from counter;
prompt
prompt
insert into orders (Order_ID, Order_Status, Order_Date, Cust_ID, Product_ID, Warehouse_num, Order_Qty, Unit_Price, Order_Amt, Ship_date, Ship_Qty, Ship_Amt)
	select maxnum, 'OPEN', sysdate, '&vCnum', '&vPnum', '&vWnum', '&vOrdqty',Unit_Price, Unit_price*'&vOrdqty' total, null, null, null
	from counter, products
	where Product_ID = '&vPnum';



set heading on
update counter set maxnum = maxnum + 1;
commit; 
spool off