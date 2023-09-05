clear screen;

DROP TABLE Invoice_1 CASCADE CONSTRAINTS;
DROP TABLE Invoice_3 CASCADE CONSTRAINTS;
DROP TABLE Customer_1 CASCADE CONSTRAINTS;
DROP TABLE Pets_1 CASCADE CONSTRAINTS;
DROP TABLE Accessories_1 CASCADE CONSTRAINTS;

DROP SEQUENCE cid_inc;
DROP SEQUENCE pet_id_inc;
DROP SEQUENCE a_id_inc;


CREATE TABLE Customer_1(
	customer_id int, 
	name varchar2(30), 
	mobile varchar2(11) unique,
	branch varchar2(6),
	PRIMARY KEY(customer_id));
	
CREATE TABLE Pets_1(
	pet_id int, 
	type_ varchar2(10), 
	gender varchar2(1),
	mutation varchar2(20),
	age float,
	price float,
	PRIMARY KEY(pet_id));
	
CREATE TABLE Accessories_1(
	a_id int, 
	title varchar2(50), 
	pet_type varchar2(20),
	category varchar2(30),
	price float,
	stock int,
	PRIMARY KEY(a_id));

CREATE TABLE Invoice_1(
	invoice_number int, 
	total_price float, 
	date_ date,
	PRIMARY KEY(invoice_number));
	
CREATE TABLE Invoice_3(
	invoice_number int, 
	customer_id int, 
	details varchar2(100),
	payment_method varchar2(20),
	order_type varchar2(30),
	PRIMARY KEY(invoice_number),
	FOREIGN KEY(customer_id) REFERENCES Customer_1(customer_id));
	
CREATE SEQUENCE cid_inc START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE pet_id_inc START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE a_id_inc START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER cid_inc_trig
BEFORE INSERT
ON Customer_1
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
	SELECT cid_inc.nextval INTO :NEW.customer_id FROM dual;
END;
/

CREATE OR REPLACE TRIGGER pet_id_inc_trig
BEFORE INSERT
ON Pets_1
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
	SELECT pet_id_inc.nextval INTO :NEW.pet_id FROM dual;
END;
/

CREATE OR REPLACE TRIGGER a_id_inc_trig
BEFORE INSERT
ON Accessories_1
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
	SELECT a_id_inc.nextval INTO :NEW.a_id FROM dual;
END;
/

	

insert into Customer_1 (name, mobile, branch) values ('Sajid Abdullah', '0155_____', 'Mirpur'); 

insert into Pets_1 (type_, gender, mutation, age, price) values ('Bird', 'M', 'Budgie Rainbow', 2.5, 300); 

insert into Accessories_1 (title, pet_type, category, price, stock) values ('Seed Mix - 1 KG', 'Bird', 'Food', 110, 100); 

insert into Invoice_1 (invoice_number, total_price, date_) values (1, 575.25, '20-Feb-2023'); 
insert into Invoice_3 (invoice_number, customer_id, details, payment_method, order_type) values (1, 1, '....', 'Cash', 'In-Store'); 

select * from Customer_1;
select * from Pets_1;
select * from Accessories_1;
select * from Invoice_1;
select * from Invoice_3;


commit;