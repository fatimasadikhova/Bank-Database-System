--Təsdiqlənmiş kredit müraciətlərinin siyahısı
SELECT 
COUNT(ApprovalStatus) as CountApproved
FROM LoanApproval
WHERE ApprovalStatus='Approved'

-- Müştərinin ümumi kredit məbləğini hesablamaq
SELECT 
C.FullName,
SUM(L.Loanamount) AS Sum_Loan_Amount
FROM Customer AS C
LEFT JOIN Loan AS L
ON C.CustomerID=L.CustomerID
GROUP BY FullName

--Son 1 ayda verilən kreditlər
SELECT * 
FROM LOAN
WHERE StartDate BETWEEN '2025-04-01' AND '2025-04-30'


--Kreditləri təstiqlənən işçilərin statistikası
SELECT 
C.CustomerID,
C.FullName,
R.STATUS
FROM CUSTOMER C
JOIN REQUEST R
ON C.CustomerID=R.CustomerID
WHERE R.STATUS='Approved'


--Customer ID 4 olan müştərinin kreditlərini tapmaq
SELECT
LoanAmount,
InterestRate,
LoanType
FROM Loan
WHERE CustomerID=4

-- Ən çox kredit məbləği götürən müştərini tap
SELECT TOP 1
FullName,
LoanAmount
FROM Customer C
JOIN Loan L
ON C.CustomerID=L.CustomerID
ORDER BY LoanAmount DESC

SELECT
FullName,
LoanAmount
FROM Customer C
JOIN Loan L
ON C.CustomerID=L.CustomerID
ORDER BY LoanAmount DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY

-- Ən çox hansı ödəniş üsulundan istifadə edilir?
SELECT 
PAYMENT_METHOD,
COUNT(payment_method) AS COUNT_PAYMENT_METHOD
FROM Installment
GROUP BY PAYMENT_METHOD
ORDER BY COUNT_PAYMENT_METHOD DESC

-- FullName sütununu ad və soyad olmaqla 2 sütuna ayır.
SELECT
LEFT(FullName, CHARINDEX(' ',FullName)) AS SURNAME,
RIGHT(FullName, LEN(FULLNAME)-CHARINDEX(' ',FULLNAME)) AS NAME
FROM Customer

-- Adı A ilə başlayan müştəriləri tap
WITH CTE AS (
SELECT
LEFT(FullName, CHARINDEX(' ',FullName)) AS SURNAME,
RIGHT(FullName, LEN(FULLNAME)-CHARINDEX(' ',FULLNAME)) AS NAME
FROM Customer
)
SELECT * FROM CTE
WHERE NAME LIKE 'A%'

--FullName A ilə başlayan
SELECT * FROM Customer
Where FullName like 'A%'

--FullName A ilə bitən
SELECT * FROM Customer
Where FullName like '%a'

--2ci hərfi h olan
SELECT * FROM Customer
Where FullName like '_h%'