USE [Lab ¹3];
CREATE TABLE dallas_dept (Lastnumber CHAR(4) NOT 
NULL, Sity CHAR(20) NOT NULL);
INSERT INTO dallas_dept (Lastnumber, Sity) SELECT 
Lastnumber, Sity
FROM department
WHERE Sity = 'Dallas';