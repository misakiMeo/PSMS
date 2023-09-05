clear screen;
SET SERVEROUTPUT ON;
SET VERIFY OFF;
SET FEEDBACK OFF

BEGIN 
	DBMS_OUTPUT.PUT_LINE('Pet Type: ');
    DBMS_OUTPUT.PUT_LINE('1. Bird');
	DBMS_OUTPUT.PUT_LINE('2. Dog');
	DBMS_OUTPUT.PUT_LINE('3. Cat');
	DBMS_OUTPUT.PUT_LINE('');
END;
/
ACCEPT t NUMBER PROMPT "Select an option : "

BEGIN 
	DBMS_OUTPUT.PUT_LINE('');
	DBMS_OUTPUT.PUT_LINE('Category: ');
    DBMS_OUTPUT.PUT_LINE('1. Food');
	DBMS_OUTPUT.PUT_LINE('2. Toys');
	DBMS_OUTPUT.PUT_LINE('3. Cage');
	DBMS_OUTPUT.PUT_LINE('4. Food Accessories');
	DBMS_OUTPUT.PUT_LINE('5. Others');
END;
/
ACCEPT c NUMBER PROMPT "Select an option : "

ACCEPT ti CHAR PROMPT "Title : "
ACCEPT p NUMBER PROMPT "Price : "
ACCEPT s NUMBER PROMPT "Stock : "

DECLARE
    T NUMBER := &t;
	C NUMBER := &c;
	TI VARCHAR2(50) := '&ti';
	P FLOAT := &p;
	S FLOAT := &s;
	
	pt varchar2(20);
	invalid_choice EXCEPTION;
Begin

	if T = 1 THEN
		pt := 'Bird';
	elsif T = 2 THEN
		pt := 'Dog';
	elsif T = 3 THEN
		pt := 'Cat';
	else
		raise invalid_choice;
	end if;
	
	
	if C = 1 THEN
		insert into Accessories_1 (title, pet_type, category, price, stock) values (TI, pt, 'Food', P, S); 	
	elsif C = 2 THEN
		--DBMS_OUTPUT.PUT_LINE('Toys @ site 2');
		insert into Accessories_2@site_2 (title, pet_type, category, price, stock) values (TI, pt, 'Toys', P, S); 	
	elsif C = 3 THEN
		--DBMS_OUTPUT.PUT_LINE('Cage @ site 2');
		insert into Accessories_2@site_2 (title, pet_type, category, price, stock) values (TI, pt, 'Cages', P, S);
	elsif C = 4 THEN
		--DBMS_OUTPUT.PUT_LINE('Food Accessories @ site 2');
		insert into Accessories_2@site_2 (title, pet_type, category, price, stock) values (TI, pt, 'Food Accessories', P, S);
	elsif C = 5 THEN
		--DBMS_OUTPUT.PUT_LINE('Others @ site 2');
		insert into Accessories_2@site_2 (title, pet_type, category, price, stock) values (TI, pt, 'Other', P, S);
	else
		raise invalid_choice;
	end if;
		
	
	EXCEPTION 
		When invalid_choice THEN
		DBMS_OUTPUT.PUT_LINE('');
		DBMS_OUTPUT.PUT_LINE('Invalid Option! Try Again!');
	
End;
/

select * from Accessories_1 union (select * from Accessories_2@site_2);
--select * from Accessories_1 union select * from Accessories_2;
