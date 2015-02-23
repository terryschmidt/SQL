--List the total balance due to each vendor, when the total balance due is over $100.
--List the vendor ID, name, phone and the total.
--Order the listing by the total balance due, descending.
SELECT 
  VENDORS.VENDOR_ID,
  VENDORS.VENDOR_NAME,
  VENDORS.VENDOR_PHONE,
  INVOICES.INVOICE_TOTAL - (INVOICES.PAYMENT_TOTAL + INVOICES.CREDIT_TOTAL) as balanceDue
FROM INVOICES, VENDORS
WHERE
  VENDORS.VENDOR_ID = INVOICES.VENDOR_ID AND
  INVOICES.INVOICE_TOTAL - (INVOICES.PAYMENT_TOTAL + INVOICES.CREDIT_TOTAL) > 100
ORDER BY
  balanceDue desc;
