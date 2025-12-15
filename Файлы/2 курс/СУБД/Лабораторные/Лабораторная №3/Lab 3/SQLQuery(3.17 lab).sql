USE [Lab ¹3];
DELETE FROM works_on WHERE Value IN (SELECT Number
FROM employee
WHERE Lastname = 'Moser');
DELETE FROM employee
WHERE Lastname = 'Moser';