-- Create Table.... As

CREATE TABLE vendors5 
AS (SELECT * FROM vendors);

CREATE TABLE invoices5
AS (SELECT * FROM invoices);


-- ALTER TABLE... ADD CONSTRAINT
 ALTER TABLE vendors5 ADD CONSTRAINT vendors5_pk 
    PRIMARY KEY (vendor_id);
	
  ALTER TABLE vendors5 ADD CONSTRAINT vendors5_vendor_name_uq 
    UNIQUE (vendor_name);
	
 ALTER TABLE vendors5 ADD CONSTRAINT vendors5_fk_terms
    FOREIGN KEY (default_terms_id) 
    REFERENCES terms (terms_id);
	
  ALTER TABLE vendors5 ADD CONSTRAINT vendors5_fk_accounts
    FOREIGN KEY (default_account_number) 
    REFERENCES general_ledger_accounts (account_number);
	

  ALTER TABLE invoices5 ADD CONSTRAINT invoices5_pk 
    PRIMARY KEY (invoice_id);
	
  ALTER TABLE invoices5 ADD CONSTRAINT invoices5_fk_vendors
    FOREIGN KEY (vendor_id) 
    REFERENCES vendors5 (vendor_id);
	
  ALTER TABLE invoices5 ADD CONSTRAINT invoices5_fk_terms
    FOREIGN KEY (terms_id) 
    REFERENCES terms (terms_id);
	
-- ADD Balance_Due column to invoices5 table

ALTER TABLE invoices5 ADD balance_due NUMBER(9, 2) DEFAULT 0;


-- UPDATE balance_due column(invoice_total - (payment_total + credit_total))

UPDATE invoices5
SET balance_due = (invoice_total - (payment_total + credit_total));


--  Insert new records to both the vendors5 and invoices5 tables.

CREATE OR REPLACE PROCEDURE vendors5_invoices5_new_records
		
AS

	vendor_id_p                   NUMBER;
	vendor_name_p                VARCHAR2(50) := 'Terry, Inc.';
	vendor_address1_p              VARCHAR2(50) := '202 Market Street';
	vendor_address2_p              VARCHAR2(50) := 'Suite A';
	vendor_city_p                   VARCHAR2(50) := 'Fresno';
	vendor_state_p                 CHAR(2) := 'CA';
	vendor_zip_code_p               VARCHAR2(20) := '93722';
	vendor_phone_p                VARCHAR2(50) := '(800) 503-6192';
	vendor_contact_last_name_p     VARCHAR2(50) := 'Brown';
	vendor_contact_first_name_p    VARCHAR2(50) := 'Sam';
	default_terms_id_p              NUMBER := 3;       
	default_account_number_p        NUMBER :=  100;  
	invoice_id_p 					          NUMBER;
	invoice_number_p        VARCHAR2(50) := '10A00';
	invoice_date_p          DATE := SYSDATE;
	invoice_total_p         NUMBER(9,2) := 5050.23;
	payment_total_p         NUMBER(9,2) := 0;
	credit_total_p          NUMBER(9,2) :=0;
	terms_id_p              NUMBER := 3;
	invoice_due_date_p      DATE;
	i               NUMBER;
  
BEGIN
		SELECT MAX(vendor_id) + 1 INTO vendor_id_p FROM vendors5;
		
		INSERT INTO vendors5(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
		VALUES(vendor_id_p,	vendor_name_p,vendor_address1_p,vendor_address2_p,vendor_city_p,vendor_state_p,vendor_zip_code_p,vendor_phone_p,vendor_contact_last_name_p,vendor_contact_first_name_p,default_terms_id_p,default_account_number_p);  
		
		i := 1;
		WHILE i < 4 LOOP
		
			
		SELECT MAX(invoice_id) + 1 INTO invoice_id_p FROM invoices5;
		
		
		SELECT SYSDATE + INTERVAL '30' DAY INTO invoice_due_date_p FROM DUAL;
		
		INSERT INTO invoices5(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date) 
		VALUES(invoice_id_p,vendor_id_p,invoice_number_p,invoice_date_p,invoice_total_p,payment_total_p,credit_total_p,terms_id_p,invoice_due_date_p);
		
		invoice_number_p := '10A00' || '0';
    invoice_total_p := invoice_total_p + 1000;
		
		i := i + 1;
    
    END LOOP;
		
END;
/

EXECUTE vendors5_invoices5_new_records;


--  Update new invoices

CREATE OR REPLACE PROCEDURE update_credit_balance
		
AS

	vendor_id_p                   NUMBER(9,2);
	 
BEGIN
		SELECT MAX(vendor_id)	INTO vendor_id_p FROM invoices5;
		
			
		UPDATE invoices5
		SET credit_total = invoice_total * 0.1
		WHERE vendor_id = vendor_id_p;
    
    UPDATE invoices5
    SET balance_due = (invoice_total - (payment_total + credit_total))
    WHERE vendor_id = vendor_id_p;
    
END;
/

EXECUTE update_credit_balance;

		

-- Show records from new tables


SELECT v.vendor_id, v.vendor_name, i.invoice_id, TO_CHAR(i.invoice_date,'MONTHDD,YYYY') AS "invoice_date", i.invoice_due_date, i.invoice_total, i.credit_total,i.balance_due
FROM vendors5 v
JOIN invoices5 i ON v.vendor_id = i.vendor_id
WHERE v.vendor_id = (SELECT MAX(vendor_id) FROM vendors5);

-- Return database to initial state

DROP TABLE invoices5;

DROP TABLE vendors5;
