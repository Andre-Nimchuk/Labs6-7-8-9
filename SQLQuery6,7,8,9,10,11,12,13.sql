6 лаба
USE [LB_1]
GO

CREATE VIEW Авто_2
AS SELECT DISTINCT Код_авто, Колір, Модель FROM Авто

USE [LB_1]
GO

SELECT * FROM Авто
WHERE Рік_випуску>2004

USE [LB_1]
GO

SELECT Авто2.Код_авто, Авто2.Колір, Авто2.Модель,
Клієнт.Імя, Клієнт.Електронна_пошта FROM Авто2, Клієнт
WHERE Авто2.код_авто = Клієнт.Код_клієнта

SELECT Авто2.Код_авто, Авто2.Колір, Авто2.Модель,
Договір_поставки.Дата_заключення, Договір_поставки.Сума_виплати FROM Авто2, Договір_поставки
WHERE Авто2.Код_авто = Договір_поставки.Код_договору_поставки AND Договір_поставки.Дата_заключення > GetDate()

7 лаба

SELECT Модель FROM Авто WHERE Код_авто = 8 

SELECT Клієнт.Код_клієнта, Клієнт.Імя, Клієнт.Електронна_пошта,
Клієнт.Номер_телефону, Клієнт.По_батькові
FROM Клієнт LEFT JOIN Договір_поставки ON
Клієнт.Код_клієнта = Договір_поставки.Код_договору_поставки

SELECT Клієнт.Імя, Авто.Модель
FROM Клієнт INNER JOIN Авто ON Клієнт.Код_клієнта = Авто.Код_авто
WHERE Модель = ''

SELECT Авто.Модель, Клієнт.Код_клієнта FROM Авто INNER JOIN Клієнт
ON Авто.Код_авто= Клієнт.Код_клієнта
WHERE Авто.Модель IN ('BMW', 'Andre')

SELECT TOP 2 Салон.Код_салону, Клієнт.Імя, Авто.Модель, Договір_про_оренду.Ціна_оренди
FROM Клієнт JOIN Авто ON Клієнт.Код_клієнта = Договір_про_оренду.Код_салону
JOIN Авто ON Клієнт.Код_клієнта = Авто.Код_авто
ORDER BY Договір_про_оренду.Ціна_оренди DESC

SELECT Клієнт.Імя FROM Клієнт
WHERE NOT EXISTS 
(SELECT * FROM Авто WHERE Авто.Код_авто = Клієнт.Код_клієнта)


SELECT Код_договору_про_оренду, Ціна_оренди AS [Ціна оренди] FROM Договір_про_оренду
WHERE Ціна_оренди > 1000;

8 лаба
SELECT Код_клієнта, Імя FROM Клієнт WHERE Імя LIKE 'M%'
ORDER BY Імя

SELECT TOP 3 Договір_про_оренду.Код_договору_про_оренду, Договір_про_оренду.Дата_заключення, Договір_про_оренду.Ціна_оренди
FROM Договір_про_оренду ORDER BY Договір_про_оренду.Дата_заключення DESC

SELECT  Договір_про_оренду.Код_договору_про_оренду, Авто.Модель
FROM Договір_про_оренду  JOIN Авто ON Договір_про_оренду.Код_клієнта = Авто.Код_авто

SELECT  COUNT(Договір_про_оренду.Код_договору_про_оренду) AS Код_клієнта, Авто.Модель
FROM Договір_про_оренду  JOIN Авто ON Договір_про_оренду.Код_договору_про_оренду = Авто.Код_авто
GROUP BY Авто.Модель

9 лаба

SELECT COUNT(Авто.Код_авто) AS КількістьАвто FROM Авто
WHERE Модель LIKE '%Mercedes%'

SELECT MONTH(Договір_про_оренду.Дата_заключення) AS Month, DAY(Договір_про_оренду.Дата_заключення) AS Day, COUNT(Договір_про_оренду.Код_договору_про_оренду) AS КількістьОрендованих
FROM Договір_про_оренду GROUP BY MONTH(Договір_про_оренду.Дата_заключення), DAY(Договір_про_оренду.Дата_заключення)

SELECT Клієнт.Код_клієнта, SUM(Договір_про_оренду.Ціна_оренди) AS Сума
FROM Клієнт LEFT JOIN Договір_про_оренду ON Клієнт.Код_клієнта=Договір_про_оренду.Код_клієнта
GROUP BY Клієнт.Код_клієнта

SELECT TOP 1 Клієнт.Код_клієнта, COUNT(Договір_про_оренду.Код_договору_про_оренду) AS КількістьОренд FROM Клієнт
JOIN Договір_про_оренду ON Клієнт.Код_клієнта = Договір_про_оренду.Код_салону
GROUP BY Клієнт.Код_клієнта
ORDER BY COUNT(Договір_про_оренду.Код_договору_про_оренду) DESC

10 лаба

CREATE FUNCTION АвтоСтр4 (@id AS int)
RETURNS nvarchar(500) AS 
BEGIN
DECLARE @returnValue nvarchar(500)
SELECT @returnValue = Авто_2.Модель + ' ' + CAST(Авто_2.Рік_випуску as nvarchar(30)) + ' ' + Авто_2.Максимальна_швидкість + ' ' + CAST(Авто_2.Тип_авто as nvarchar(10))
FROM Авто_2 WHERE Код_авто = @id
RETURN @returnValue
END

CREATE FUNCTION АвтоСтр4 (@id AS int)
RETURNS nvarchar(500) AS 
BEGIN
DECLARE @returnValue nvarchar(500)
SELECT @returnValue = Авто_2.Модель + ' ' + CAST(Авто_2.Рік_випуску as nvarchar(30)) + ' ' + Авто_2.Максимальна_швидкість + ' ' + CAST(Авто_2.Тип_авто as nvarchar(10))
FROM Авто_2 WHERE Код_авто = @id
RETURN @returnValue
END

USE [LB_1]
GO
SELECT dbo.АвтоСтр4 (1) AS 'АвтоСтрока'

EXEC ПрокатАвто @Модель='inserted',  @Рік_випуску=2007, @Колір ='Колір', @Тип_авто = 3;

11 лаба
BEGIN TRANSACTION;
INSERT INTO [Контракт] 
VALUES (1,2,1, '12.02.2020', '10.03.2020');
INSERT INTO [Контракт] 
VALUES (2,3,1, '10.03.2020', '12.02.2020');
INSERT INTO [Контракт] 
VALUES (3,4,1, '12.10.2020', '10.03.2020');
COMMIT;

USE [LB_1]
GO


BEGIN TRANSACTION;
INSERT INTO [Контракт] 
VALUES (1,1,1, '12.02.2020', '10.03.2020');
INSERT INTO [Контракт] 
VALUES (2,2,2, '10.03.2020', '12.02.2020');
INSERT INTO [Контракт] 
VALUES (3,3,3, '12.10.2020', '10.03.2020');
COMMIT;

12 лаба 

USE [LB_1]
GO

CREATE
TRIGGER Delete_Атво1 ON [Авто] 
INSTEAD OF DELETE 
AS
BEGIN
DECLARE @Old INT
SELECT @Old = [Код_авто] FROM deleted
UPDATE [Авто] SET Тип_авто=1 WHERE Тип_авто=@Old
END

DELETE FROM [Авто] WHERE [Код_авто] = 5 ;
SELECT * FROM [Авто];

ALTER TABLE [Авто]
ADD Остання_оренда DATE NULL;

select [Код_авто], Тип_авто, [Колір], Модель, Рік_випуску, Максимальна_швидкість,  Остання_оренда from [Авто]

CREATE TRIGGER 
ост_фікс2 ON [Договір_про_оренду] AFTER INSERT
AS
BEGIN
UPDATE [Авто] SET [Авто].Остання_оренда=CONVERT(date, inserted.[Дата_заключення])
FROM inserted
WHERE [Авто].[Код_авто] = inserted.[Код_авто]
END
INSERT INTO [Авто] 
VALUES
(10, 3, 'Black', 'Aston', '1978', '1580','2021-10-05')

13 лаба 

EXEC sp_helpindex 'Авто'
GO

EXEC sp_helpindex 'Салон'

CREATE INDEX autINDX3 ON Авто ([Код_авто]); 
EXEC sp_helpindex 'Авто'
GO

CREATE UNIQUE INDEX CалонINDX ON Салон ([Код_салону], [Назва_салону]); 
EXEC sp_helpindex 'Салон'
GO

SET SHOWPLAN_ALL ON;  
GO  
select [Тип_авто],[Модель] from [Авто]
where [Максимальна_швидкість]>'200';
GO
select [Код_салону], [Назва_салону] from [Салон]
where [Місто_розташування]='Львів';
GO
SET SHOWPLAN_ALL OFF;  
GO  

