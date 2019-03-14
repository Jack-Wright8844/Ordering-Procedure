set feedback off
set echo off
set verify off
set heading on
spool c:/DBMS/agingspool.txt

prompt ****** Aging Report ******
prompt Today's Date: 
select sysdate from dual;

accept vDatenum prompt 'Please enter number of days to query: ';

column order_ID heading 'Order Number'format a11
column Order_Date heading 'Order Date' format a11
column Order_status heading 'Order Status' format a12
column Product_ID heading 'Product Number' format a8
column Product_Name heading 'Product Name' format a20
column Order_Qty heading 'Order Quantity' format a9
column Unit_Price heading 'Unit Price' format $999.99
column Order_Amt heading 'Order Amount' format $9999.99
column total heading 'Days Open'

select Order_ID, Order_Date, Order_Status, o.Product_ID, p.Product_Name, Order_Qty, o.Unit_Price, Order_amt, trunc(sysdate) - trunc(o.order_date) total
from Orders o, products p
where o.Product_ID = p.Product_ID and trunc(sysdate) - trunc(o.order_date) >= '&vDatenum' and Order_Status = 'Open';

spool off