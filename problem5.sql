--List the invoices with a balance due that are at least 7 months past the due date.
--Display the vendor ID & name, invoice number, date, due date and balance due.
--Calculating the past due period should be based on the current run date, not a hard-coded date.
--Order the listing by the due date.
SELECT INVOICE_ID,
  VENDORS.VENDOR_ID,
  VENDORS.VENDOR_NAME,
  INVOICE_NUMBER,
  INVOICE_DATE,
  INVOICE_DUE_DATE,
  INVOICES.INVOICE_TOTAL - (INVOICES.PAYMENT_TOTAL + INVOICES.CREDIT_TOTAL) as balanceDue, 
  TRUNC(sysdate) - TRUNC(INVOICE_DUE_DATE) as daysPastDue
FROM INVOICES, VENDORS
WHERE
  VENDORS.VENDOR_ID = INVOICES.VENDOR_ID AND
  TRUNC(sysdate) - TRUNC(INVOICE_DUE_DATE) > 210 AND
  PAYMENT_DATE is null
ORDER BY
  INVOICE_DUE_DATE;
