SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE sampleProcedure
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

END sampleProcedure;
/



BEGIN
	sampleProcedure;
END;
/
