clear screen;
SET SERVEROUTPUT ON;
SET VERIFY OFF;
SET FEEDBACK OFF;


BEGIN
	DBMS_OUTPUT.PUT_LINE('Pets List: ');
	DBMS_OUTPUT.PUT_LINE('Pet ID' || chr(9) || 'Type' || chr(9) || 'Mutation' || chr(9) || 'Price' || chr(9) );
	pkg.showPets;
	DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------------------');
END;
/

ACCEPT t NUMBER PROMPT "Select a pet : "
ACCEPT n char PROMPT "Customer phone number : "

BEGIN
	DBMS_OUTPUT.PUT_LINE('Payment Method: ');
	DBMS_OUTPUT.PUT_LINE('1. Cash');
	DBMS_OUTPUT.PUT_LINE('2. Card');
	DBMS_OUTPUT.PUT_LINE('3. bKash');
	
END;
/

ACCEPT opt NUMBER PROMPT "Select an option : "

declare
	O NUMBER := &opt;
	T number := &t;
	nPrice float := 0;
	vat float;
	total float;
	
	N varchar2(11) := '&n';
	cid int := -1;
	
	pay_method varchar2(20);
	cus_not_found EXCEPTION;
	invalid_choice EXCEPTION;
	
	inv_no int;
	
	date_c date;
begin
	
	for R in (select * from Customer_2)  LOOP
		if N = R.mobile THEN
			cid := R.customer_id;
		end if;
	end loop;
	
	if cid=-1 THEN
		for R in (select * from Customer_1@site_1)  LOOP
			if N = R.mobile THEN
				cid := R.customer_id;
			end if;
		end loop;
	end if;
	
	if cid=-1 then
		raise cus_not_found;
	end if;
			
		
	DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------------------');
	select price into nPrice from (select pet_id, price from Pets_2 union select pet_id, price from Pets_3) where pet_id=T;
	DBMS_OUTPUT.PUT_LINE('Price : '||nPrice);
	vat := pkg.calcVAT(nPrice);
	DBMS_OUTPUT.PUT_LINE('Vat : '||vat);
	total := nPrice + vat;
	DBMS_OUTPUT.PUT_LINE('Total price: '||total);
	DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------------------');
	
	
	select trunc(dbms_random.value(1,10000)) into inv_no from dual;
	SELECT TO_CHAR(CURRENT_DATE, 'DD-MON-YYYY') into date_c FROM dual;

	if O = 1 then
		--DBMS_OUTPUT.PUT_LINE('Site 1 cash');
		insert into Invoice_1@site_1 (invoice_number, total_price, date_) values (inv_no, total, date_c);
		insert into Invoice_3@site_1 (invoice_number, customer_id, details, payment_method, order_type) values (inv_no, cid, 'Dog/Cat', 'Card', 'In-Store'); 
	elsif O = 2 THEN
		insert into Invoice_2 (invoice_number, total_price, date_) values (inv_no, total, date_c);
		insert into Invoice_4 (invoice_number, customer_id, details, payment_method, order_type) values (inv_no, cid, 'Dog/Cat', 'Card', 'In-Store'); 
	elsif O = 3 THEN
		insert into Invoice_2 (invoice_number, total_price, date_) values (inv_no, total, date_c);
		insert into Invoice_4 (invoice_number, customer_id, details, payment_method, order_type) values (inv_no, cid, 'Dog/Cat', 'bKash', 'In-Store'); 
	else
		raise invalid_choice;
	end if;
		
		
	EXCEPTION 
		When NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('');
		DBMS_OUTPUT.PUT_LINE('Invalid Pet ID! Try Again!');
		
		When cus_not_found THEN
		DBMS_OUTPUT.PUT_LINE('');
		DBMS_OUTPUT.PUT_LINE('Customer not found! Try Again!');
		
		When invalid_choice THEN
		DBMS_OUTPUT.PUT_LINE('');
		DBMS_OUTPUT.PUT_LINE('Invalid Option! Try Again!');
end;
/

--select * from Invoice_2;
--select * from Invoice_4;
