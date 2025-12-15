USE [Lab ¹3]; UPDATE works_on
SET Name = NULL
WHERE Lastnumber IN ( SELECT Lastnumber
FROM employee
WHERE Lastname = 'Jones');