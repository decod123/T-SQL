CREATE DATABASE Food
ON
(
Name = Food_Data,
FileName = 'D:\RDSDBDATA\DATA\Food_Data.mdf',
Size = 221MB,
Maxsize = Unlimited,
Filegrowth = 16MB
)
LOG ON
(
Name = Food_Log,
FileName = 'D:\RDSDBDATA\DATA\Food_Log.ldf',
Size = 29MB,
Maxsize = Unlimited,
Filegrowth = 10%
);

USE Food;

CREATE TABLE Snack
(
SnackName varchar(50),
Amount int,
Calories int
);

SELECT *
FROM Snack;


INSERT Snack
SELECT 'Honeycomb', 90, 110;

--views
CREATE VIEW vwSnacks
AS
SELECT * FROM Snack;

SELECT *
FROM vwSnacks;

ALTER VIEW vwSnacks
AS
SELECT * FROM Snack
WHERE Calories < 1000;

--stored procedures



--triggers
