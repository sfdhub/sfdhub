USE [Lab ¹3];
MERGE INTO bonus B
USING (SELECT Lastnumber, budget FROM project) E
ON (B.pr_no = E.Lastnumber) WHEN MATCHED THEN
UPDATE SET B.bonus = E.budget * 0.1 WHEN NOT 
MATCHED THEN
INSERT (pr_no, bonus)
VALUES (E.Lastnumber, E.budget * 0.05);