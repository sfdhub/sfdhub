DECLARE @email AS VARCHAR(20)='test@t.com'

--With Encryption As If @email Like '_%@%.%' Select 'Email прошёл валидацию'
--Else Select 'Некоректный email'
IF (
     CHARINDEX(' ',LTRIM(RTRIM(@email))) = 0 
AND  LEFT(LTRIM(@email),1) <> '@' 
AND  RIGHT(RTRIM(@email),1) <> '.' 
AND  CHARINDEX('.',@email ,CHARINDEX('@',@email)) - CHARINDEX('@',@email ) > 1 
AND  LEN(LTRIM(RTRIM(@email ))) - LEN(REPLACE(LTRIM(RTRIM(@email)),'@','')) = 1 
AND  CHARINDEX('.',REVERSE(LTRIM(RTRIM(@email)))) >= 3 
AND  (CHARINDEX('.@',@email ) = 0 AND CHARINDEX('..',@email ) = 0)
)
   print 'Email прошёл валидацию'
ELSE
   print 'Некоректный email'