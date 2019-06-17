---------------------------------------------------------------------------------------------------

Select DISTINCT employee.empl_name,
LOWER(REPLACE(CONCAT(REGEXP_SUBSTR(employee.EMPL_NAME , '[^ ]+' , 1 , 1),
CONCAT('.', CONCAT(REGEXP_SUBSTR(employee.EMPL_NAME , '[^ ]+' , 1 , 2), '@csf.co.id' ))),' ',''))
AS Email
from fifapps.fs_mst_employees employee
where employee.empl_status != 'RS' AND email_address is null
AND REGEXP_INSTR(empl_name,' ') != 0;

---------------------------------------------------------------------------------------------------

Select employee.empl_name,
LOWER(CONCAT(REPLACE(REGEXP_SUBSTR(employee.EMPL_NAME , '[^ ]+' , 1 , 1),' ',''), '@csf.co.id' ))
AS Email
from fifapps.fs_mst_employees employee
where employee.empl_status != 'RS'AND REGEXP_INSTR(empl_name,' ') = 0 AND email_address is null;

---------------------------------------------------------------------------------------------------



--make function
CREATE OR REPLACE Function GenerateEmail
   RETURN varchar2 AS Email varchar2(50)

BEGIN

   SELECT employee.empl_name
   FROM fifapps.fs_mst_employees employee

   IF REGEXP_INSTR(empl_name,' ') != 0 and employee.empl_status != 'RS' and email_address is null THEN
      Email := LOWER(REPLACE(CONCAT(REGEXP_SUBSTR(employee.EMPL_NAME , '[^ ]+' , 1 , 1),
CONCAT('.', CONCAT(REGEXP_SUBSTR(employee.EMPL_NAME , '[^ ]+' , 1 , 2), '@csf.co.id' ))),' ',''));

   ELSIF employee.empl_status != 'RS'and REGEXP_INSTR(empl_name,' ') = 0 and email_address is null
      Email := LOWER(CONCAT(REPLACE(REGEXP_SUBSTR(employee.EMPL_NAME , '[^ ]+' , 1 , 1),' ',''), '@csf.co.id' ));

   END IF;

   RETURN Email;

END Email;
