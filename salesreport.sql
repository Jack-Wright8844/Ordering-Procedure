set heading on
set verify off
set feedback off
set echo off
spool c:/DBMS/SalesReportSpool.txt
prompt
prompt ***** SALES REPORT ******
prompt

column Product_ID heading 'Product Number' format a8
column Product_Name heading 'Product Description' format a20
column Ordate heading 'Order Month' format a11
column count(Order_ID) heading 'No. of Orders' format 9999999
column sum(order_Qty) heading 'Total Units' format 999999
column total heading 'Total Amount' format $99,9999

select orders.product_ID, products.product_name, to_char(Order_Date, 'mm/yyyy') ordate, count(Order_ID), sum(Order_Qty), orders.unit_price * sum(order_qty) total
from products, orders
where orders.product_ID = products.Product_ID
group by orders.product_ID, product_name, to_char(Order_date, 'mm/yyyy'), orders.Unit_Price
order by orders.product_ID, product_name;


