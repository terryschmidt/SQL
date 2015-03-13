--List the total for each line item description, giving the description and the total amount when the total > $5,000.
--Use formatting and concatenation to reduce the space required for the description and to format the total as currency.
--Order the output by the total, descending.

SELECT 
      INVOICE_ID,
      INVOICE_SEQUENCE,
      ACCOUNT_NUMBER,
      TO_CHAR(LINE_ITEM_AMT, '$999999999.99') as LineItemAmountFMT,
      LINE_ITEM_DESCRIPTION
FROM 
      INVOICE_LINE_ITEMS
WHERE 
      LINE_ITEM_AMT > 5000
ORDER BY
      LINE_ITEM_AMT desc;
