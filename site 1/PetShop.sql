clear screen;
SET SERVEROUTPUT ON;
SET VERIFY OFF;

BEGIN 
    DBMS_OUTPUT.PUT_LINE('1. Add Customer');
	DBMS_OUTPUT.PUT_LINE('2. Pets and Accessories');
	DBMS_OUTPUT.PUT_LINE('3. Generate Invoice');
	DBMS_OUTPUT.PUT_LINE('4. Sales Details');
	
END;
/

ACCEPT X NUMBER PROMPT "Choose an option : "

DECLARE
    N number;
	invalid_choice EXCEPTION;
	
Begin
	
	N := &X;
	
	if N=1 THEN
		DBMS_OUTPUT.PUT_LINE('Option 1 selected');
		
	else RAISE invalid_choice;
	end if;


	EXCEPTION 
		When invalid_choice THEN
		DBMS_OUTPUT.PUT_LINE('Invalid Option');

End;
/

