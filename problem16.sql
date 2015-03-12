--List the vendors, that are not in California or Michigan, with more than 2 invoices dated within the same week of the year.
--
--        	List the vendor name and state, and each vendor should only appear once.

SELECT DISTINCT VENDOR_NAME, VENDOR_STATE
FROM INVOICEVENDORS
WHERE VENDOR_STATE <> 'CA' AND VENDOR_STATE <> 'MI'
GROUP BY VENDOR_NAME, VENDOR_STATE, INVOICE_DATE
HAVING COUNT(TO_CHAR(INVOICE_DATE, 'WW')) > 2;
