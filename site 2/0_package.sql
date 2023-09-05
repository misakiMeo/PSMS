SET SERVEROUTPUT ON;

CREATE OR REPLACE PACKAGE pkg AS
	PROCEDURE showPets;
	
	FUNCTION calcVAT(p IN float)
	RETURN float;
	
	FUNCTION findCustomer(c IN int)
	RETURN int;
end pkg;
/

CREATE OR REPLACE PACKAGE BODY pkg AS

	PROCEDURE showPets
	IS
	nid int;
	ntyPe_ VARCHAR2(10);
	nMutation VARCHAR2(20);
	nprice float;
	BEGIN
		for R in (select * from Pets_2 union select * from Pets_3) LOOP
			nid := R.pet_id;
			ntyPe_ := R.type_;
			nMutation := R.mutation;
			nprice := R.price;
			DBMS_OUTPUT.PUT_LINE(nid || chr(9) || ntyPe_ || chr(9) || nMutation || chr(9) || nprice || chr(9) );
			--DBMS_OUTPUT.PUT_LINE(ntyPe_ );
		end LOOP;

	END showPets;
	
	
	FUNCTION calcVAT(p IN float)
	RETURN float
	IS 
	v float;
	BEGIN
		v := p * 0.075;
		return v;
	END calcVAT;
	
end pkg;
/	
	