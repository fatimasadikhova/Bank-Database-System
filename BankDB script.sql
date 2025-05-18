CREATE DATABASE BankDB

CREATE TABLE Customer (
	CustomerID INT PRIMARY KEY,
	FullName VARCHAR(30) NOT NULL,
	Address VARCHAR(50),
	Phone VARCHAR(30) UNIQUE,
	Email VARCHAR(30) UNIQUE
)

ALTER TABLE Customer
ALTER COLUMN FullName NVARCHAR(100)  --Nütün hərfləri tanıması üçün data tipi nvarchar olaraq dəyişdirdim

ALTER TABLE Customer
ALTER COLUMN Address NVARCHAR(255)  
--yeni sütun əlavə etdim
ALTER TABLE Customer
ADD salary int 

CREATE TABLE Account (
	AccountID INT PRIMARY KEY,
	CustomerID INT,
	AccountType VARCHAR(30), 
	Balance DECIMAL(12,2),
	OpenDate DATE,
	--AccountType sütununa yalnız aşağıdakı dəyərlər yazıla bilər
	CONSTRAINT chk_AccountType CHECK (AccountType IN ('Savings', 'Current', 'FixedDeposit')),
	CONSTRAINT fk_CustomerID FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
)

CREATE TABLE Loan(
	LoanID INT PRIMARY KEY,
	CustomerID INT,
	LoanAmount DECIMAL(12,2),
	InterestRate DECIMAL(12,2),
	LoanType INT,
	StartDate DATE,
	EndDate DATE,
	CONSTRAINT fk_CustID FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	CONSTRAINT chk_LoanType CHECK (LoanType IN ('Personal', 'Home', 'Auto')),
)

--LoanType data tipini deyisdim
ALTER TABLE Loan
DROP CONSTRAINT chk_LoanType

ALTER TABLE Loan
ALTER COLUMN LoanType VARCHAR(30)

ALTER TABLE Loan
ADD CONSTRAINT chk_LoanType CHECK (LoanType IN ('Personal', 'Home', 'Auto'))

CREATE TABLE Payment(
	PaymentID INT PRIMARY KEY,
	LoanID INT,
	CustomerID int,
	PaymentDate DATE,
	AmountPaid DECIMAL(12,2),
	CONSTRAINT FK_LOANID FOREIGN KEY (LoanID) REFERENCES Loan(LoanID),
	constraint fk_cid foreign key (CustomerID) references Customer(CustomerID)
)



CREATE TABLE Employee (
	EmployeeID INT PRIMARY KEY,
	FullName VARCHAR(30) NOT NULL,
	Position VARCHAR(30) NOT NULL,
	Branch VARCHAR(30) NOT NULL,
	Email VARCHAR(30) NOT NULL
)


CREATE TABLE LoanApproval (
    LoanApprovalID INT PRIMARY KEY,
    RequestID INT,
    CustomerID INT,  -- Müştərinin identifikatoru
    ApprovalDate DATE,
    ApprovedAmount DECIMAL(18, 2),
    InterestRate DECIMAL(5, 2),
    RepaymentTerm INT,
    LoanType VARCHAR(50),
    ApprovalStatus VARCHAR(50),
    FOREIGN KEY (RequestID) REFERENCES Request(RequestID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
ALTER TABLE LoanApproval
ADD EmployeeID INT
foreign key (EmployeeID) REFERENCES Employee(EmployeeID)

CREATE TABLE REQUEST (
	RequestID INT PRIMARY KEY,
	CustomerID int,
	STATUS VARCHAR(30),
	ST_DATE DATE,
	CONSTRAINT fk_FULLNAME FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	CONSTRAINT chk_Status CHECK (Status IN ('Approved', 'Pending', 'Rejected'))
	)
	
CREATE TABLE Installment(
	Installment_ID int primary key,
	LoanID int,
	CustomerID int,
	Amount numeric,
	Due_date date, --odenis edilmeli tarix
	paid_date date, --odenis edildiyi tarix
	payment_method varchar(30),
	CONSTRAINT  loanfk foreign key (LoanID) references Loan(LoanID),
	CONSTRAINT fkcustomerid FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	CONSTRAINT payment_method CHECK (payment_method IN ('cash','card','bank transfer'))
)


INSERT INTO Customer ( CustomerID, FullName, Address, Phone, Email)
	VALUES (1, N'Cafarova Ayan', N'28 May küçəsi, AZ1145 Bakı​', '055 400-20-30','ceferovayan@gmail.com'),
	(2, N'Mammadova Asiman', N'Ələt qəsəbəsi, AZ1081 Bakı', '055 500-55-60', 'memmedayan354@gmail.com'),
	(3, N'Ahmedov Anar', N'Əmircan qəsəbəsi, AZ1042 Bakı​', '050 454-80-90', 'memmedovaasimoan12@gmail.com'),
	(4, N'Musayeva Zeyneb', N'Bakıxanov qəsəbəsi, AZ1000 Bakı', '050 444-32-56', 'zeynebmusayeva00@gmail.com'),
	(5, N'Ağayev Tural', N'Balaxanı qəsəbəsi, AZ1038 Bakı​', '070 567-67-78', 'aghayevhtural@gmail.com'),
	(6, N'Babayev Anar', N'Biləcəri qəsəbəsi, AZ1117 Bakı', '050 343-45-54', 'babayevhanar@gmail.com'),
	(7, N'Macidov Cavad', N'Bilgəh qəsəbəsi, AZ1094 Bakı', '055 454-67-89', 'mecidovcavad@gmail.com'),
	(8, N'Musayeva Aysu', N'Binə qəsəbəsi, AZ1045 Bakı​', '070 432-14-23', 'aysumusayeva00@gmail.com'),
	(9, N'Mammədova Aişa', N'Binəqədi rayonu, AZ1000 Bakı', '077 654-33-44', 'mammadovaaisha@gmail.com'),
	(10, N'Aliyev Rustam', N'Balaxanı qəsəbəsi, AZ1038 Bakı​', '070-346-58-32', 'rustamaliyev@gmail.com')
	select * from Customer
	select * from Loan
UPDATE Customer
SET Salary = 1200
WHERE CustomerID = 2;

UPDATE Customer
SET Salary = 1000
WHERE CustomerID = 3;

UPDATE Customer
SET Salary = 1500
WHERE CustomerID in (1,4,5,6,9,10);


INSERT INTO Account (AccountID, CustomerID, AccountType, Balance, OpenDate)
	VALUES (1, 1, 'Savings', 1500.50, '2025-01-15'),
	(2, 2, 'Current', 3200.00, '2025-02-20'),
	(3, 3, 'FixedDeposit', 5000.75, '2025-03-05'),
	(4, 4, 'Savings', 1200.00, '2025-03-10'),
	(5, 5, 'Current', 2100.30, '2025-01-30'),
	(6, 6, 'FixedDeposit', 7500.00, '2025-02-25'),
	(7, 7, 'Savings', 3000.00, '2025-04-01'),
	(8, 8, 'Current', 800.60, '2025-04-03'),
	(9, 9, 'FixedDeposit', 9500.00, '2025-02-10'),
	(10, 10, 'Savings', 6000.50, '2025-03-15')


INSERT INTO Loan (LoanID, CustomerID, LoanAmount, InterestRate, LoanType, StartDate, EndDate)
	VALUES (1, 1, 15000.00, 5.0, 'Personal', '2025-04-20', DATEADD(month,60,'2025-04-20')),
	(2, 4, 20000.00, 4.5, 'Home', '2025-04-27', DATEADD(month,48,'2025-04-27')),
	(3, 5, 10000.00, 6.0, 'Auto', '2025-04-27', DATEADD(month,36,'2025-04-27')),
	(4, 6, 25000.00, 5.2, 'Personal', '2025-04-26', DATEADD(month,72,'2025-04-26')),
	(5, 9, 12000.00, 4.8,'Home' , '2025-04-22',DATEADD(month,60,'2025-04-22')),
	(6, 10, 18000.00, 5.5, 'Auto', '2025-04-27', DATEADD(month,36,'2025-04-27'))


--consantrait sildim
ALTER TABLE Loan
DROP CONSTRAINT chk_Status
--status sutununu sildim
ALTER TABLE Loan
DROP COLUMN Status


INSERT INTO Payment (PaymentID ,LoanID , CustomerID, PaymentDate ,AmountPaid)
	VALUES (1, 1,1, '2025-05-20',377.42 ),
	(2, 2, 4, '2025-05-27', 456.07 ),
	(3, 3, 5, '2025-05-27', 304.22),
	(4, 4,6, '2025-05-26', 404.95),
	(5, 5,9, '2025-05-22', 225.36),
	(6, 6,10, '2025-05-27', 543.53)


INSERT INTO Employee (EmployeeID, FullName, Position, Branch, Email)
	VALUES (1, N'Rashidov Mammad', N'Kredit Meneceri', N'Baku', 'rashidov.mammad@email.com'),
	(2, N'Agazade Tunar', N'Kredit Analitiki', N'Baku', 'agazade.tunar@email.com'),
	(3, N'Mustafayeva Leyla', N'Kredit Mütexessisi', N'Sumgait', 'mustafayeva.leyla@email.com'),
	(4, N'Aliyev Tunar', N'Kredit Meneceri', N'Baku', 'aliyev.tunar@email.com'),
	(5, N'Abdullayeva Zeyneb', N'Kredit Meneceri', N'Baku', 'abdullayeva.zeyneb@email.com'),
	(6, N'Ferecov Orkhan', N'Kredit Mütexessisi', N'Baku', 'ferecov.orkhan@email.com'),
	(7, N'Memmedova Ayten', N'Kredit Analitiki', N'Baku', 'memmedova.ayten@email.com'),
	(8, N'Quliyev Elmar', N'Kredit Mütexessisi', N'Baku', 'quliyev.elmar@email.com'),
	(9, N'Ehmedova Shabnam', N'Kredit Meneceri', N'Baku', 'ehmedova.shabnam@email.com'),
	(10, N'Veliyev Ziyad', N'Kredit Mütexessisi', N'Baku', 'veliyev.ziad@email.com')


INSERT INTO LoanApproval (LoanApprovalID, RequestID, CustomerID, ApprovalDate, ApprovedAmount, InterestRate, RepaymentTerm, LoanType, ApprovalStatus)
VALUES
(1,1, 1, '2025-04-20', 15000.00, 5.0, 60, 'Personal', 'Approved'),
(2,4, 4, '2025-04-27', 20000.00, 4.5, 48, 'Home', 'Approved'),
(3,5, 5, '2025-04-27', 10000.00, 6.0, 36, 'Auto', 'Approved'),
(4,6, 6, '2025-04-26', 25000.00, 5.2, 72, 'Personal', 'Approved'),
(5,9, 9, '2025-04-22', 12000.00, 4.8, 60, 'Home', 'Approved'),
(6,10, 10,'2025-04-27', 18000.00, 5.5, 36, 'Auto', 'Approved')


--sequence yaratmaq
CREATE SEQUENCE RequestID
    START WITH 1       -- Başlanğıc dəyəri
    INCREMENT BY 1     -- Hər dəfə artırılacaq dəyər
    NO MINVALUE        -- Minimum dəyər yoxdur
    NO MAXVALUE        -- Maksimum dəyər yoxdur
    CACHE 10;          -- Ardıcılın 10 dəyərini yaddaşda saxla


insert  into REQUEST (RequestID , CustomerID, STATUS , ST_DATE)
	values(NEXT VALUE FOR RequestID,1,'Approved','2025-04-20'),
	(NEXT VALUE FOR RequestID,2,'Pending','2025-04-25'),
	(NEXT VALUE FOR RequestID,3,'Pending','2025-04-25'),
	(NEXT VALUE FOR RequestID,4,'Approved','2025-04-27'),
	(NEXT VALUE FOR RequestID,5,'Approved','2025-04-27'),
	(NEXT VALUE FOR RequestID,6,'Approved','2025-04-26'),
	(NEXT VALUE FOR RequestID,7,'Rejected','2025-04-26'),
	(NEXT VALUE FOR RequestID,8,'Rejected','2025-04-27'),
	(NEXT VALUE FOR RequestID,9,'Approved','2025-04-22'),
	(NEXT VALUE FOR RequestID,10,'Approved','2025-04-27')

INSERT INTO Installment(Installment_ID,LoanID,CustomerID,Amount,Due_date,paid_date,payment_method)
VALUES (1,1,1,377.42,'2025-05-20','2025-05-18','bank transfer'),
	(2,2,4,456.07,'2025-05-27','2025-05-28','card'),
	(3,3,5, 304.22,'2025-05-27','2025-05-27','card'),
	(4,4,6, 404.95, '2025-05-26','2025-05-30','cash'),
	(5,5,9,250, '2025-05-22', '2025-05-20','card'),
	(6,6,10, 540,'2025-05-27','2025-05-27', 'bank transfer')





	--PROQRAM TƏMİNASTINDA İSTİFADƏ ETMƏK ÜÇÜN CUSTOMER_NEW CƏDVƏLI YARADIRAM

	CREATE TABLE Customers_New (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100),
    Address NVARCHAR(200),
    Phone NVARCHAR(20),
    Email NVARCHAR(100),
    Salary FLOAT
);

