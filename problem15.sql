--Use CREATE TABLE ... AS ... and NATURAL JOIN to create a table named InvoiceVendors containing all of the attributes from both invoices and vendors (other than eliminating the duplicate vendor id).

create table InvoiceVendors as (SELECT * FROM vendors NATURAL JOIN invoices)
