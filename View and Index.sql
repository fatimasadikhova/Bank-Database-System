--View
--Kredir məbləği 15.000-dən çox olanlar müştəriləri göstər.
CREATE VIEW CUSTOMER_LOAN AS
SELECT 
FullName,
LoanAmount
FROM Customer C
JOIN LOAN L
ON C.CustomerID=L.CustomerID

SELECT * FROM CUSTOMER_LOAN
WHERE LoanAmount>15000

    
-- Index
CREATE INDEX idx_CustomerName ON Customer(FullName)

SELECT * FROM Customer
WHERE FullName like '%Zeyneb'

CREATE NONCLUSTERED INDEX idx_FullName
ON Customer(FullName)



CREATE PROCEDURE ProcedureName
AS
BEGIN
    -- Məsələn, INSERT əməliyyatı
    INSERT INTO Customer (CustomerID, FullName)
    VALUES (1, 'Fatimə');

    -- UPDATE əməliyyatı
    UPDATE Customer
    SET FullName = 'Fatimə Sadıxova'
    WHERE CustomerID = 1;

    -- DELETE əməliyyatı
    DELETE FROM Customer
    WHERE CustomerID = 1;
END;

