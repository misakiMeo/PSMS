clear screen;
SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT n CHAR PROMPT "Customer Name : "
ACCEPT m CHAR PROMPT "Customer Mobile : "

DECLARE
    N VARCHAR2(30) := '&n';
	M VARCHAR2(11) := '&m';
	
Begin


	
	insert into Customer_2 (name, mobile, branch) values (N, M, 'Uttara'); 
	commit;
	
	EXCEPTION 
		when DUP_VAL_ON_INDEX then
			DBMS_OUTPUT.PUT_LINE('Mobile Number Already Exists! Please try again');
End;
/

select * from Customer_1@site_1 UNION select * from Customer_2;
--select * from Customer_1 UNION select * from Customer_2;