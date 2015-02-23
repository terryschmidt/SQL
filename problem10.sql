--List the top 10 percent of the invoices based on the highest balance due.
--Give the vendor name, invoice date and balance due.
WITH GOT_TENTH AS
(
  SELECT VENDOR_NAME, INVOICE_DATE, (INVOICE_TOTAL - (PAYMENT_TOTAL + CREDIT_TOTAL)) as balancedue,
    NTILE (10) OVER (ORDER BY (INVOICE_TOTAL - (PAYMENT_TOTAL + CREDIT_TOTAL))) AS tenth
    
  FROM INVOICES JOIN VENDORS
    ON INVOICES.VENDOR_ID = VENDORS.VENDOR_ID
)
SELECT VENDOR_NAME, INVOICE_DATE, balancedue
FROM GOT_TENTH
WHERE tenth = 10
ORDER BY balancedue DESC;
