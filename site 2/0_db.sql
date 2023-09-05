clear screen;

DROP TABLE Invoice_2 CASCADE CONSTRAINTS;
DROP TABLE Invoice_4 CASCADE CONSTRAINTS;
DROP TABLE Customer_2 CASCADE CONSTRAINTS;
DROP TABLE Pets_2 CASCADE CONSTRAINTS;
DROP TABLE Pets_3 CASCADE CONSTRAINTS;
DROP TABLE Accessories_2 CASCADE CONSTRAINTS;

DROP SEQUENCE cid2_inc;
DROP SEQUENCE pet2_id_inc;
DROP SEQUENCE pet3_id_inc;
DROP SEQUENCE a2_id_inc;



CREATE TABLE Customer_2(
	customer_id int, 
	name varchar2(30), 
	mobile varchar2(11) unique,
	branch varchar2(6),
	PRIMARY KEY(customer_id));
	
CREATE TABLE Pets_2(
	pet_id int, 
	type_ varchar2(10), 
	gender varchar2(1),
	mutation varchar2(20),
	age float,
	price float,
	PRIMARY KEY(pet_id));
	
CREATE TABLE Pets_3(
	pet_id int, 
	type_ varchar2(10), 
	gender varchar2(1),
	mutation varchar2(20),
	age float,
	price float,
	PRIMARY KEY(pet_id));
	
CREATE TABLE Accessories_2(
	a_id int, 
	title varchar2(50), 
	pet_type varchar2(20),
	category varchar2(30),
	price float,
	stock int,
	PRIMARY KEY(a_id));

CREATE TABLE Invoice_2(
	invoice_number int, 
	total_price float, 
	date_ date,
	PRIMARY KEY(invoice_number));
	
CREATE TABLE Invoice_4(
	invoice_number int, 
	customer_id int, 
	details varchar2(100),
	payment_method varchar2(20),
	order_type varchar2(30),
	PRIMARY KEY(invoice_number));
	--FOREIGN KEY(customer_id) REFERENCES Customer_2(customer_id));
	
CREATE SEQUENCE cid2_inc START WITH 5000 INCREMENT BY 1;
CREATE SEQUENCE pet2_id_inc START WITH 1000 INCREMENT BY 1;
CREATE SEQUENCE pet3_id_inc START WITH 2000 INCREMENT BY 1;
CREATE SEQUENCE a2_id_inc START WITH 2000 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER cid2_inc_trig
BEFORE INSERT
ON Customer_2
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
	SELECT cid2_inc.nextval INTO :NEW.customer_id FROM dual;
END;
/

CREATE OR REPLACE TRIGGER pet2_id_inc_trig
BEFORE INSERT
ON Pets_2
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
	SELECT pet2_id_inc.nextval INTO :NEW.pet_id FROM dual;
END;
/

CREATE OR REPLACE TRIGGER pet3_id_inc_trig
BEFORE INSERT
ON Pets_3
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
	SELECT pet3_id_inc.nextval INTO :NEW.pet_id FROM dual;
END;
/


CREATE OR REPLACE TRIGGER a2_id_inc_trig
BEFORE INSERT
ON Accessories_2
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
	SELECT a2_id_inc.nextval INTO :NEW.a_id FROM dual;
END;
/

	

insert into Customer_2 (name, mobile, branch) values ('Mahmud Hasan', '012____', 'Uttara'); 

insert into Pets_2 (type_, gender, mutation, age, price) values ('Dog', 'M', 'German Spitz', 12, 12000); 
insert into Pets_3 (type_, gender, mutation, age, price) values ('Cat', 'F', 'Persian longhair', 10, 25000); 

insert into Accessories_2 (title, pet_type, category, price, stock) values ('Water Pot', 'Bird', 'Food Accessories', 50, 60); 

insert into Invoice_2 (invoice_number, total_price, date_) values (1, 575.25, '20-Feb-2023'); 
insert into Invoice_4 (invoice_number, customer_id, details, payment_method, order_type) values (1, 5003, '....', 'Card', 'In-Store'); 

select * from Customer_2;
select * from Pets_2;
select * from Pets_3;
select * from Accessories_2;
select * from Invoice_2;
select * from Invoice_4;


commit;