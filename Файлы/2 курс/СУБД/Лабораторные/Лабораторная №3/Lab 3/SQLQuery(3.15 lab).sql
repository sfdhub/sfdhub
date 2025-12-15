USE [Lab ¹3]; UPDATE project
SET budget = CASE
WHEN budget >0 and budget < 100000 THEN
budget*1.2
WHEN budget >= 100000 and budget < 200000 THEN
budget*1.1 ELSE budget*1.05
END