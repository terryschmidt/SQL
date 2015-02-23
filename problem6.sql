--List the total balance due to each vendor, when the total balance due is over $100.
--Just list the vendor name and the total.
--Order the listing by the vendor name.
SELECT 
  VENDORS.VENDOR_NAME,
  INVOICES.INVOICE_TOTAL - (INVOICES.PAYMENT_TOTAL + INVOICES.CREDIT_TOTAL) as balanceDue
FROM INVOICES, VENDORS
WHERE
  VENDORS.VENDOR_ID = INVOICES.VENDOR_ID AND
  INVOICES.INVOICE_TOTAL - (INVOICES.PAYMENT_TOTAL + INVOICES.CREDIT_TOTAL) > 100
ORDER BY
  VENDOR_NAME;
