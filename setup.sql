set echo on

spool c:\DBMS\setup.txt

drop table orders;
drop table inventory;
drop table warehouse;
drop table products;
drop table customers;
drop table counter;

create table counter(
	maxnum int,
	primary key(maxnum));

insert into counter values ('1006');

create table customers (
	CustID varchar2(3),
	Clast varchar2(15),
	Cfirst varchar2(15),
	Cphone varchar2(15),
	Cshipaddress varchar2(25),
	Ccity varchar2(20),
	Cstate varchar2(5),
	Czip varchar2(10),
	primary key (CustID));

insert into customers values ('101','John','Doe','(310) 221-6293','4825 Green St','New York','NY','49272');
insert into customers values ('102','Johnson','Katey','(562) 332-3664','1947 Inglewood St','Big Shore','WY','81642');
insert into customers values ('103','Chipperson','Chip','(714) 038-1927','4223 Chainwood Ave','Lakewood','CA','90808');
insert into customers values ('104','Brown','Buster','(957) 534-3153','1122 Tropical St','1843 Rainforest','CA','91808');
insert into customers values ('105','Putnim','Seth','(582) 297-1957','1235 Redondo Ave','Libsen','WA','96731');

create table products (
	Product_ID varchar2(3),
	Product_Name varchar2(10),
	Unit_Price number (7,2),
	primary key (Product_ID));

insert into products values ('p1','Calculator','9.99');
insert into products values ('p2','Pen','2.99');
insert into products values ('p3','Knife','6.49');
insert into products values ('p4','Book','4.99');
insert into products values ('p5','pencil','2.49');


create table warehouse (
	Warehouse_num varchar2(3),
	Warehouse_Address varchar2(45),
	Warehouse_City varchar2(15),
	Warehouse_State varchar2(10),
	Warehouse_Zip varchar2(8),
	Warehouse_Phone varchar2(15),
	primary key (Warehouse_num));

insert into warehouse values ('w1','3271 Atherton Ave','Dallas','TX','90372','4328470184');
insert into warehouse values ('w2','28143 Grey Goose St','New York','NY','95732','9338574631');
insert into warehouse values ('w3','2184 Brown Sound Bay','Green Bay','WI','3751','1039487465');
insert into warehouse values ('w4','31234 Seahawks are Bad Lane','Seattle','WA','19485','2847568394');
insert into warehouse values ('w5','12384 NeverRaiders St','Oakland','CA','75623','6577489376');
insert into warehouse values ('w6','12356 Chipperson Chip St','New England','MA','74632','7563829274');

create table inventory (
	Product_ID varchar2(3),
	Warehouse_num varchar2(3),
	Inventory_Quantity number (7,2),
	primary key (Warehouse_num, Product_ID),
	Constraint warehouse foreign key (Warehouse_num)
	references warehouse (Warehouse_num),
	Constraint products foreign key (Product_ID)
	references products (Product_ID));

insert into inventory values ('p1','w1','3000');
insert into inventory values ('p1','w4','3200');
insert into inventory values ('p2','w2','600');
insert into inventory values ('p3','w3','550');
insert into inventory values ('p4','w5','1000');
insert into inventory values ('p5','w6','200');

create table orders (
	Order_ID int,
	Order_date date,
	Order_Status varchar2(7),
	Order_Qty number (7,2),
	Order_Amt varchar2(6),
	Ship_Date date,
	Ship_Qty number (7,2),
	Ship_Amt number (7,2),
	Unit_Price number (7,2),
	Cust_ID varchar2(4),
	Product_ID varchar2(3),
	Warehouse_num varchar2(3),
	DaysOpen number (7,2),
	primary key (Order_ID),
	constraint orders foreign key (Cust_ID)
	references customers (CustID),
	constraint Oproducts foreign key (Product_ID)
	references products (Product_ID),
	constraint Owarehouse foreign key (Warehouse_num)
	references warehouse (Warehouse_num));

insert into orders values ('1000','21-December-17','OPEN','15','null','19-september-17','20','39.80','1.99','101','p2','w2','30');
insert into orders values ('1001','18-September-17','OPEN','20','null','09-august-17','25','62.25','2.49','103','p5','w6','20');
insert into orders values ('1002','13-March-17','OPEN','25','null','20-July-17','14','48.86','3.49','105','p3','w3','45');
insert into orders values ('1003','13-April-17','OPEN','30','null','23-February-17','40','119.60','2.99','102','p1','w1','15');
insert into orders values ('1004','06-July-17','OPEN','35','null','27-May-17','10','29.90','2.99','102','p1','w4','25');
insert into orders values ('1005','03-May-17','OPEN','40','null','10-March-17','100','499.00','4.99','104','p4','w5','60');

commit;

spool off