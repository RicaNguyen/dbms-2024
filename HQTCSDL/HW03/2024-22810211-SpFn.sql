--- Ho ten: Nguyễn Ba Hoài Nhựt
--- MSSV: 22810211
--- Khóa: 2022-2
--- Quản lý ngân hàng

GO
USE [master]
GO

DROP DATABASE IF EXISTS [QLNH]
GO

CREATE DATABASE [QLNH];
GO

USE [QLNH];
GO

CREATE TABLE Account (
Id INT,
CustomerName nvarchar(50),
Balance MONEY DEFAULT 0,
PRIMARY KEY (Id)
)

CREATE TABLE TransHistory (
Id INT IDENTITY(1,1),
transDate DATETIME DEFAULT CURRENT_TIMESTAMP,
fromAccId INT,
[type] CHAR(1) CHECK ([type] IN ('T', 'W', 'U')),
PRIMARY KEY (Id),
)

ALTER TABLE TransHistory ADD 
	CONSTRAINT TransHistory_Account_fk
	FOREIGN KEY (fromAccId) REFERENCES Account(Id);

INSERT INTO Account (Id, CustomerName, Balance)
VALUES (1, N'Nguyễn Văn A', 1900000);
INSERT INTO Account (Id, CustomerName, Balance)
VALUES (2, N'Bùi Thị Cam', 20000000);
INSERT INTO Account (Id, CustomerName, Balance)
VALUES (3, N'Bành Thị Bưởi', 3234340);

-- YC2: Viết hàm thực hiện việc kiểm tra sự tồn tại của 1 tài khoản ngân hàng
GO
CREATE OR ALTER FUNCTION [dbo].ufn_checkAccExists_22810211 (@accId INT) 
RETURNS INT
AS
BEGIN 
	DECLARE @isAccExists INT;
	SELECT @isAccExists = count(*) FROM Account WHERE Id = @accId;
	RETURN  @isAccExists
END
GO


-- YC3: Viết hàm thực hiện việc kiểm tra số dư của 1 tài khoản ngân hàng
GO
CREATE OR ALTER FUNCTION [dbo].ufn_checkAccBalance_22810211 (@accId INT, @amount MONEY) 
RETURNS INT
AS BEGIN 
	DECLARE @checkAmount INT;
	SELECT @checkAmount = count(*) FROM Account WHERE Id = @accId AND Balance> @amount;
	RETURN @checkAmount;
END
GO

-- YC4: xây dựng thủ tục nội – stored procedure cho việc chuyển khoản 
-- tiền từ 1 tài khoản A sang tài khoản B theo mô tả và yêu cầu sau
GO
CREATE OR ALTER PROCEDURE [dbo].usp_transferMoney_22810211 
    @fromAccId INT, 
    @toAccId INT, 
    @amount MONEY 
AS
BEGIN
	DECLARE @checkAcc1 INT = 0;
	DECLARE @checkAcc2 INT = 0;
	DECLARE @infoAcc1 nvarchar(255) = '';
	DECLARE @infoAcc2 nvarchar(255) = '';

	SET @checkAcc1 = dbo.ufn_checkAccExists_22810211(@fromAccId);
	SET @checkAcc2 =  dbo.ufn_checkAccExists_22810211(@toAccId);

	IF @checkAcc1 = 0 OR @checkAcc2 = 0
		BEGIN
			PRINT N'Tài khoản không tồn tại';
			RETURN
		END

	SELECT @infoAcc1 = CONCAT(N'Thông tin tài khoản nguồn:',Id,' ', CustomerName, ' ', Balance) FROM Account WHERE Id = @fromAccId;
	SELECT @infoAcc2 = CONCAT(N'Thông tin tài khoản đích:',Id,' ', CustomerName, ' ', Balance) FROM Account WHERE Id = @toAccId;
	
	PRINT @infoAcc1;
	PRINT @infoAcc2;

	IF dbo.ufn_checkAccBalance_22810211(@fromAccId, @amount) = 0
		BEGIN
			PRINT N'Số dư tài khoản nguồn không đủ';
			RETURN
		END

	-- https://www.w3schools.com/sql/func_sqlserver_convert.asp
	-- format 121 để in yyyy-mm-dd hh:mi:ss.mmm
	PRINT N'Thờ gian bắt đầu thủ tục:' +  CONVERT(NVARCHAR, GETDATE(), 121);

	DECLARE @acc1Balance MONEY = 0;
	DECLARE @acc2Balance MONEY = 0;

	SELECT @acc1Balance=Balance FROM Account WHERE Id = @fromAccId;
	SELECT @acc2Balance=Balance FROM Account WHERE Id = @ToAccId;

	UPDATE Account SET Balance = @acc1Balance - @amount WHERE Id = @fromAccId;
	UPDATE Account SET Balance = @acc2Balance + @amount WHERE Id = @fromAccId;

	INSERT INTO TransHistory (fromAccId, type) VALUES (@fromAccId, 'T');

	SELECT @infoAcc1 = CONCAT(N'Thông tin tài khoản nguồn:',Id,' ', CustomerName, ' ', Balance) FROM Account WHERE Id = @fromAccId;
	SELECT @infoAcc2 = CONCAT(N'Thông tin tài khoản đích:',Id,' ', CustomerName, ' ', Balance) FROM Account WHERE Id = @toAccId;

	PRINT N'Thờ gian kết thúc thủ tục:' +  CONVERT(NVARCHAR, GETDATE(), 121);
END
GO

EXEC usp_transferMoney_22810211 1, 2, 1000;