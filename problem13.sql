--Using a subquery or an outer join, give a count of the number of vendors that have no invoices at all.

SELECT COUNT(vendors.vendor_id) as totalUnassigned
FROM vendors
WHERE NOT EXISTS (SELECT * FROM invoices WHERE vendors.vendor_id  = invoices.vendor_id);
