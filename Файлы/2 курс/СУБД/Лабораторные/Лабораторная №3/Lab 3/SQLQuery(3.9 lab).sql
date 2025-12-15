USE [Lab ¹3];
CREATE TABLE clerk_t (Value INT NOT NULL, 
Lastnumber CHAR(4), Date DATE);
INSERT INTO clerk_t (Value, Lastnumber, Date) 
SELECT Value, Lastnumber, Date
FROM works_on WHERE Name = 'Clerk'
AND Lastnumber  = 'p2';