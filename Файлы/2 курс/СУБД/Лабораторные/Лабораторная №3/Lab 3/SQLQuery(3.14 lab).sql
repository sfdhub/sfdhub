USE [Lab ¹3]; UPDATE works_on
SET Name = NULL
FROM works_on, employee WHERE Lastname = 'Jones'
AND works_on.Name = employee.Lastnumber;