--Create a function Percentage accepting two numbers, and returning the ratio of the first number to the second one as a percentage.
--        	Passing 20 and 80 would return 25 (not .25). Return zero if the denominator is zero.

CREATE OR REPLACE FUNCTION QUESTION5PERCENTAGE
(PARAM1 IN NUMBER, PARAM2 IN NUMBER)
RETURN NUMBER AS
BEGIN
  if param2 = 0 then
  return 0;
  else
  RETURN 100 * (PARAM1 / PARAM2);
  end if;
END QUESTION5PERCENTAGE;
