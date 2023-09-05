clear screen;
SET SERVEROUTPUT ON;
SET VERIFY OFF;
SET FEEDBACK OFF

--ACCEPT t CHAR PROMPT "Pet Type : "
BEGIN 
	DBMS_OUTPUT.PUT_LINE('Pet Type: ');
    DBMS_OUTPUT.PUT_LINE('1. Bird');
	DBMS_OUTPUT.PUT_LINE('2. Cat');
	DBMS_OUTPUT.PUT_LINE('3. Dog');
	DBMS_OUTPUT.PUT_LINE('');
END;
/

ACCEPT t NUMBER PROMPT "Select an option : "
BEGIN 
	DBMS_OUTPUT.PUT_LINE('');
	DBMS_OUTPUT.PUT_LINE('Gender: ');
    DBMS_OUTPUT.PUT_LINE('1. Male');
	DBMS_OUTPUT.PUT_LINE('2. Female');
	DBMS_OUTPUT.PUT_LINE('3. Unknown');
	DBMS_OUTPUT.PUT_LINE('');
END;
/
ACCEPT g NUMBER PROMPT "Select an option : "
ACCEPT m CHAR PROMPT "Mutation : "
ACCEPT a NUMBER PROMPT "Age(Months) : "
ACCEPT p NUMBER PROMPT "Price : "

DECLARE
    T NUMBER := &t;
	G NUMBER := &g;
	M VARCHAR2(20) := '&m';
	A FLOAT := &a;
	P FLOAT := &p;
	
	nGender VARCHAR2(1);
	invalid_choice EXCEPTION;
Begin

	--DBMS_OUTPUT.PUT_LINE('Type is :' || T);
	--DBMS_OUTPUT.PUT_LINE('Age is :' || A);
	--DBMS_OUTPUT.PUT_LINE('Price is :' || P);
	
	if G = 1 then
		nGender := 'M';
	elsif G = 2 then
		nGender := 'F';
	elsif G = 3 then
		nGender := 'U';
	else
		raise invalid_choice;
	end if;
	
	
	if T = 1 THEN
		insert into Pets_1 (type_, gender, mutation, age, price) values ('Bird', nGender, M, A, P);	
	elsif T = 2 THEN
		DBMS_OUTPUT.PUT_LINE('DOG @ site 2');
	elsif T = 3 THEN
		DBMS_OUTPUT.PUT_LINE('CAT @ site 2');
	else
		raise invalid_choice;
	end if;
		
	
	EXCEPTION 
		When invalid_choice THEN
		DBMS_OUTPUT.PUT_LINE('');
		DBMS_OUTPUT.PUT_LINE('Invalid Option! Try Again!');
	
End;
/

select * from Pets_1;