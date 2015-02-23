--List the top 5 invoices based on the highest balance due.
--Give the vendor name, invoice date and balance due.
SELECT 
  *
FROM
(SELECT
  VENDOR_NAME,
  INVOICE_DATE,
  INVOICES.INVOICE_TOTAL - (INVOICES.PAYMENT_TOTAL + INVOICES.CREDIT_TOTAL) as balanceDue
FROM 
  INVOICES, VENDORS
WHERE
  VENDORS.VENDOR_ID = INVOICES.VENDOR_ID
ORDER BY
  balanceDue desc)
WHERE
  ROWNUM <= 5;
