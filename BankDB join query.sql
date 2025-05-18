SELECT 
FullName,
LoanAmount
FROM Customer C
JOIN LOAN L
ON C.CustomerID=L.CustomerID


SELECT
FullName,
Due_date,
Paid_date,
CASE 
	WHEN Due_date < paid_date then 'Gecikib'
	ELSE 'Vaxtinda ödenilib'
END AS OdenishStatusu
FROM Installment I
LEFT JOIN Customer C
ON I.CustomerID=C.CustomerID



--HANSI LOAN TYPELAR DAHA COX GECIKIB
WITH cte AS (
    SELECT 
        CustomerID,
        CASE 
            WHEN Due_date < Paid_date THEN 'Gecikib'
            ELSE 'Vaxtinda ödenilib'
        END AS OdenishStatusu
    FROM Installment
)

SELECT 
    L.LoanType,
    COUNT(CASE WHEN c.OdenishStatusu = 'Gecikib' THEN 1 ELSE NULL END) AS SAY
FROM LoanApproval L
LEFT JOIN cte C ON L.CustomerID = C.CustomerID
GROUP BY L.LoanType;



SELECT 
FullName
FROM Customer
WHERE CustomerID IN(
    SELECT CustomerID
    FROM Loan
    WHERE LoanAmount = (SELECT MAX(LoanAmount) FROM Loan)
)







