--1.     	Use UNION to list the vendors supplying a line item containing 'CICS' or 'MVS'.
--        	Include the vendor ID and name.

select vendors.vendor_id, vendors.vendor_name
from invoice_line_items, invoices, vendors
where invoice_line_items.LINE_ITEM_DESCRIPTION like '%CICS%' AND invoices.invoice_id = invoice_line_items.invoice_id AND invoices.vendor_id = vendors.vendor_id
UNION
select vendors.vendor_id, vendors.vendor_name
from vendors, invoice_line_items, invoices
where invoice_line_items.LINE_ITEM_DESCRIPTION like '%MVS%' AND invoices.invoice_id = invoice_line_items.invoice_id AND invoices.vendor_id = vendors.vendor_id;
