
SELECT
      VENDOR_ID, VENDOR_NAME, VENDOR_CONTACT_FIRST_NAME ||' '|| VENDOR_CONTACT_LAST_NAME as Name, VENDOR_CITY || ' ' || VENDOR_STATE as CityState
FROM
      VENDORS
WHERE
      VENDOR_STATE in ('IL', 'IN', 'IA', 'MI', 'MN', 'WI')
ORDER BY
      VENDOR_STATE, VENDOR_CITY;