-- ====================================================================================
-- Developer: Gunisha Malhotra
-- Date: 27/02/2026
-- Assignment: Homework #4
-- Due Date: 03/04/2026
-- ====================================================================================

-- ====================================================================================
-- this statement will change the database to YOUR database.
-- USE Gunisha Malhotra
-- ====================================================================================
-- ====================================================================================
-- this statement will prevent messages of "(1 row(s) affected)"
SET NOCOUNT ON
-- ====================================================================================

-- ====================================================================================
-- NOTES FOR ALL USERS:
-- Note: When you see a -- (dash-dash) the line is commented.
-- Note: When you see a block of code surrounded by /* */ all that code is commented.
-- ====================================================================================

-- ====================================================================================
-- NOTES FOR SQL SERVER MANAGEMENT STUDIO USERS ONLY:
-- Note: If you'd like to see your results in text format (not grid),
-- press CTRL+T and run your script.
-- Note: If you want to get back to the grid format, press CTRL+D
-- ====================================================================================

-- ====================================================================================
-- NOTES FOR AZURE DATA STUDIO and VISUAL STUDIO CODE USERS:
-- Note: There's not a straight forward way to see your results text mode instead of
-- grid.
-- ====================================================================================

-- ====================================================================================
-- START CreateTablesForHomeworks
-- ====================================================================================

-- ====================================================================================
-- drop foreign keys
-- ====================================================================================

IF OBJECT_ID('FK_ROLE_SHOW') IS NOT NULL
	ALTER TABLE Role DROP CONSTRAINT IF EXISTS FK_ROLE_SHOW

IF OBJECT_ID('FK_ROLE_ACTOR') IS NOT NULL
	ALTER TABLE Role DROP CONSTRAINT IF EXISTS FK_ROLE_ACTOR

IF OBJECT_ID('FK_SHOWAWARD_SHOW') IS NOT NULL
	ALTER TABLE ShowAward DROP CONSTRAINT IF EXISTS FK_SHOWAWARD_SHOW

IF OBJECT_ID('FK_SHOWAWARD_AWARD') IS NOT NULL
	ALTER TABLE ShowAward DROP CONSTRAINT IF EXISTS FK_SHOWAWARD_AWARD

IF OBJECT_ID('FK_VIEWING_SHOW') IS NOT NULL
	ALTER TABLE Viewing DROP CONSTRAINT IF EXISTS FK_VIEWING_SHOW

IF OBJECT_ID('FK_VIEWING_PLATFORM') IS NOT NULL
	ALTER TABLE Viewing DROP CONSTRAINT IF EXISTS FK_VIEWING_PLATFORM

IF OBJECT_ID('FK_VIEWING_VIEWER') IS NOT NULL
	ALTER TABLE Viewing DROP CONSTRAINT IF EXISTS FK_VIEWING_VIEWER

IF OBJECT_ID('FK_VIEWER_BESTFRIEND') IS NOT NULL
	ALTER TABLE Viewer DROP CONSTRAINT IF EXISTS FK_VIEWER_BESTFRIEND

IF OBJECT_ID('FK_SHOW_GENRE') IS NOT NULL
	ALTER TABLE Show DROP CONSTRAINT IF EXISTS FK_SHOW_GENRE

IF OBJECT_ID('FK_SHOW_DIRECTOR') IS NOT NULL
	ALTER TABLE Show DROP CONSTRAINT IF EXISTS FK_SHOW_DIRECTOR

-- ====================================================================================
-- drop tables
-- ====================================================================================
DROP TABLE IF EXISTS Role
DROP TABLE IF EXISTS ShowAward
DROP TABLE IF EXISTS Viewing
DROP TABLE IF EXISTS Viewer
DROP TABLE IF EXISTS Platform
DROP TABLE IF EXISTS Award
DROP TABLE IF EXISTS Actor
DROP TABLE IF EXISTS Show
DROP TABLE IF EXISTS Director
DROP TABLE IF EXISTS Genre

-- ====================================================================================
-- create tables
-- ====================================================================================
CREATE TABLE Genre
(
    GenreID INT IDENTITY(10,1) NOT NULL,
    GenreDescription VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Genre PRIMARY KEY CLUSTERED (GenreID ASC)
)

CREATE TABLE Director
(
    DirectorID INT IDENTITY(20,1) NOT NULL,
	FirstName VARCHAR(25) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	Gender CHAR(1) NUll,
	CONSTRAINT PK_Director PRIMARY KEY CLUSTERED (DIRECTORID ASC)
)

CREATE TABLE Show
(
    ShowID INT IDENTITY(30,1) NOT NULL,
	Title VARCHAR(50) NOT NULL,
	DateReleased DATE NOT NULL,
	Description VARCHAR(100) NOT NULL,
	BoxOfficeEarnings DECIMAL(15,2) NOT NULL,
	IMDBRating INT NOT NULL,
	IsMovie BIT NOT NULL,
	GenreID INT NOT NULL,
	DirectorID INT NOT NULL,
	CONSTRAINT PK_Show PRIMARY KEY CLUSTERED (ShowID ASC)
)

CREATE TABLE Award
(
    AwardID INT IDENTITY(40,1) NOT NULL,
	Name VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Award PRIMARY KEY CLUSTERED (AwardID ASC)
)

CREATE TABLE Actor
( 
    ActorID INT IDENTITY(50,1) NOT NULL,
	FirstName VARCHAR(25) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	Gender	Char(1) NOT NULL,
	CONSTRAINT PK_Actor PRIMARY KEY CLUSTERED (ActorID ASC)
)

CREATE TABLE Platform
(
    PlatformID INT IDENTITY(60,1) NOT NULL,
    PlatformName VARCHAR(50) NOT NULL,
    IsInternetBased BIT NOT NULL,
    CONSTRAINT PK_PlatformID PRIMARY KEY CLUSTERED (PlatformID ASC)
)


CREATE TABLE Viewer
(
    ViewerID INT IDENTITY(70,1) NOT NULL,
	FirstName VARCHAR(25) NOT NULL,
	MI CHAR (1)  NULL,
	LastName VARCHAR(50) NOT NULL,
	Gender CHAR(1) NULL,
	BestFriendID INT NULL,
	CONSTRAINT PK_Viewer PRIMARY KEY CLUSTERED (ViewerID ASC)
)

CREATE TABLE ShowAward
(
    ShowID INT NOT NULL,
	AwardID INT NOT NULL,
	YearWon INT NOT NULL,
	CONSTRAINT PK_ShowAward PRIMARY KEY CLUSTERED (ShowID,AwardID ASC)
)

CREATE TABLE Role
(
     ShowID INT NOT NULL,
	 ActorID INT NOT NULL,
	 CharacterName VARCHAR(50) NOT NULL,
	 Salary INT NOT NULL
	 CONSTRAINT PK_Role PRIMARY KEY CLUSTERED (ShowID,ActorID ASC)
)

CREATE TABLE Viewing
(
      ViewerID INT NOT NULL,
	  PlatformID INT NOT NULL,
	  ShowID INT NOT NULL,
      WatchDateTime DATETIME NOT NULL,
	  ViewerRatingStars DECIMAL(3,2) NOT NULL
	  CONSTRAINT PK_Viewing PRIMARY KEY CLUSTERED (ViewerID, PlatformID, ShowID ASC)
)


-- ====================================================================================
-- create foreign keys
-- ====================================================================================

ALTER TABLE Show
ADD CONSTRAINT FK_SHOW_GENRE
FOREIGN KEY (GenreID)
REFERENCES Genre (GenreID)

ALTER TABLE Show
ADD CONSTRAINT FK_SHOW_DIRECTOR
FOREIGN KEY (DirectorID)
REFERENCES Director (DirectorID)

ALTER TABLE Role
ADD CONSTRAINT FK_ROLE_SHOW
FOREIGN KEY (ShowID)
REFERENCES Show (ShowID)

ALTER TABLE Role
ADD CONSTRAINT FK_ROLE_ACTOR
FOREIGN KEY (ActorID)
REFERENCES ACTOR (ActorID)

ALTER TABLE ShowAward
ADD CONSTRAINT FK_SHOWAWARD_SHOW
FOREIGN KEY (ShowID)
REFERENCES Show (ShowID)

ALTER TABLE ShowAward
ADD CONSTRAINT FK_SHOWAWARD_AWARD
FOREIGN KEY (AwardID)
REFERENCES Award (AwardID)

ALTER TABLE Viewing
ADD CONSTRAINT FK_VIEWING_SHOW
FOREIGN KEY (ShowID)
REFERENCES Show (ShowID)

ALTER TABLE Viewing
ADD CONSTRAINT FK_VIEWING_PLATFORM
FOREIGN KEY (PlatformID)
REFERENCES Platform (PlatformID)

ALTER TABLE Viewing
ADD CONSTRAINT FK_VIEWING_VIEWER
FOREIGN KEY (ViewerID)
REFERENCES Viewer (ViewerID)

ALTER TABLE Viewer
ADD CONSTRAINT FK_VIEWER_BESTFRIEND
FOREIGN KEY (BestFriendID)
REFERENCES Viewer (ViewerID)

ALTER TABLE Viewer
ALTER COLUMN MI CHAR(1) NULL


-- ====================================================================================
-- insert data
-- ====================================================================================
INSERT INTO Genre (GenreDescription) VALUES ('Thriller')
INSERT INTO Genre (GenreDescription) VALUES ('Horror')
INSERT INTO Genre (GenreDescription) VALUES ('Mystery')
INSERT INTO Genre (GenreDescription) VALUES ('Rom-com')
INSERT INTO Genre (GenreDescription) VALUES ('Sci-fi')
INSERT INTO Genre (GenreDescription) VALUES ('Drama')


INSERT INTO Director (FirstName,LastName,Gender) VALUES ('Christopher', 'Nolan', 'M')
INSERT INTO Director (FirstName,LastName,Gender) VALUES ('David', 'Fincher', 'M')
INSERT INTO Director (FirstName,LastName,Gender) VALUES ('Woody', 'Allen', 'M')
INSERT INTO Director (FirstName,LastName,Gender) VALUES ('Alfred', 'Hitchcock', 'M')
INSERT INTO Director (FirstName,LastName,Gender) VALUES ('Greta', 'Gerwig', 'F')
INSERT INTO Director (FirstName,LastName,Gender) VALUES ('Chloe', 'Zhao', 'F')


INSERT INTO Show (Title, DateReleased, Description, BoxOfficeEarnings, IMDBRating, IsMovie, GenreID, DirectorID) VALUES ('Intersteallar', '10/26/2014', 'Scienctific Theory', 773000000, 8, 1, 14, 20)
INSERT INTO Show (Title, DateReleased, Description, BoxOfficeEarnings, IMDBRating, IsMovie, GenreID, DirectorID) VALUES ('Mind Hunter', '10/13/2017' , 'Murder Documentary', 21100000, 8, 0, 10, 21)
INSERT INTO Show (Title, DateReleased, Description, BoxOfficeEarnings, IMDBRating, IsMovie, GenreID, DirectorID) VALUES ('Manhattan', '04/25/1979' , 'Romance', 39900000, 7, 1, 13, 22)
INSERT INTO Show (Title, DateReleased, Description, BoxOfficeEarnings, IMDBRating, IsMovie, GenreID, DirectorID) VALUES ('Mr & Mrs Smith', '01/31/1941' , 'Mystery', 14000000, 6, 1, 12, 23)
INSERT INTO Show (Title, DateReleased, Description, BoxOfficeEarnings, IMDBRating, IsMovie, GenreID, DirectorID) VALUES ('Young American Bodies', '01/01/2002' , 'Drama', 9000000, 7, 0,15, 24)
INSERT INTO Show (Title, DateReleased, Description, BoxOfficeEarnings, IMDBRating, IsMovie, GenreID, DirectorID) VALUES ('Eternals', '11/05/2021' , 'Sci-fi', 1100000, 6, 0, 14, 25)	  


INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Anne', 'Hathway', 'F')
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Holt', 'McCallany', 'M')
INSERT INTO Actor (FirstName, LastName, Gender) VALUES (' Diane', 'Keaton', 'F')
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Robert', 'Montgomery', 'M')
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Joe', 'Swanberg', 'M')
INSERT INTO Actor (FirstName, LastName, Gender) VALUES ('Angelina', 'Jolie', 'F')


INSERT INTO Award (Name) VALUES ('Cinematography')
INSERT INTO Award (Name) VALUES ('Documentary Feature')
INSERT INTO Award (Name) VALUES ('Actress in Leading Role')
INSERT INTO Award (Name) VALUES ('Best Casting')
INSERT INTO Award (Name) VALUES ('Actor in Supporting Role')
INSERT INTO Award (Name) VALUES ('Film Editing')


INSERT INTO Platform (PlatformName, IsInternetBased) VALUES ('HBO', 1)
INSERT INTO Platform (PlatformName, IsInternetBased) VALUES ('Netflix', 1)
INSERT INTO Platform (PlatformName, IsInternetBased) VALUES ('Hulu', 1)
INSERT INTO Platform (PlatformName, IsInternetBased) VALUES ('PrimeVideo', 1)
INSERT INTO Platform (PlatformName, IsInternetBased) VALUES ('AppleTv', 0)
INSERT INTO Platform (PlatformName, IsInternetBased) VALUES ('Disney', 1)


INSERT INTO Viewer (FirstName, MI, LastName, Gender, BestFriendID) VALUES ('Kylie', Null, 'Talyor', 'F', Null)
INSERT INTO Viewer (FirstName, MI, LastName, Gender, BestFriendID) VALUES ('Joni', Null, 'Parson', 'F', Null)
INSERT INTO Viewer (FirstName, MI, LastName, Gender, BestFriendID) VALUES ('Sophie', Null, 'Baek', 'F', Null)
INSERT INTO Viewer (FirstName, MI, LastName, Gender, BestFriendID) VALUES ('Anthony', Null, 'Bridgerton', 'M', Null)
INSERT INTO Viewer (FirstName, MI, LastName, Gender, BestFriendID) VALUES ('Kent', Null, 'Mondrich', 'M', Null)
INSERT INTO Viewer (FirstName, MI, LastName, Gender, BestFriendID) VALUES ('Benedict', Null, 'Washington', 'M', Null)


UPDATE Viewer SET BestFriendID = 74 WHERE ViewerID = 70
UPDATE Viewer SET BestFriendID = 75 WHERE ViewerID = 71
UPDATE Viewer SET BestFriendID = 73 WHERE ViewerID = 72
UPDATE Viewer SET BestFriendID = 74 WHERE ViewerID = 73
UPDATE Viewer SET BestFriendID = NULL WHERE ViewerID = 74
UPDATE Viewer SET BestFriendID = NULL WHERE ViewerID = 75


INSERT INTO ShowAward (ShowID, AwardID, YearWon) VALUES (30, 43, 2015)
INSERT INTO ShowAward (ShowID, AwardID, YearWon) VALUES (31, 41, 2018)
INSERT INTO ShowAward (ShowID, AwardID, YearWon) VALUES (32, 45, 1980)
INSERT INTO ShowAward (ShowID, AwardID, YearWon) VALUES (33, 40, 1942)
INSERT INTO ShowAward (ShowID, AwardID, YearWon) VALUES (34, 42, 2007)
INSERT INTO ShowAward (ShowID, AwardID, YearWon) VALUES (35, 44, 2022)


INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (30, 50, 'Brand', 6000000)
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (31, 51, 'Bill Tench', 100000)
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (32, 52, 'Mary Wilkie', 70000)
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (33, 53, 'David Smith', 65000)
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (34, 54, 'Ben', 90000)
INSERT INTO Role (ShowID, ActorID, CharacterName, Salary) VALUES (35, 55, 'Thena', 3500000)


INSERT INTO Viewing ( ViewerID, PlatformID, ShowID, WatchDateTime, ViewerRatingStars) VALUES (70, 60, 30, '07-07-2020 08:15:40 AM', 8.9)
INSERT INTO Viewing ( ViewerID, PlatformID, ShowID, WatchDateTime, ViewerRatingStars) VALUES (71, 63, 31, '09-10-2025 11:15:45 AM', 7.8)
INSERT INTO Viewing ( ViewerID, PlatformID, ShowID, WatchDateTime, ViewerRatingStars) VALUES (72, 62, 32, '11-11-2023 12:00:30 AM', 6.7)
INSERT INTO Viewing ( ViewerID, PlatformID, ShowID, WatchDateTime, ViewerRatingStars) VALUES (73, 61, 33, '12-01-2020 23:45:20 PM', 7.9)
INSERT INTO Viewing ( ViewerID, PlatformID, ShowID, WatchDateTime, ViewerRatingStars) VALUES (74, 64, 34, '01-01-2019 10:30:14 AM', 6.7)
INSERT INTO Viewing ( ViewerID, PlatformID, ShowID, WatchDateTime, ViewerRatingStars) VALUES (75, 65, 35, '06-07-2022 15:15:17 PM', 9.0)

-- ====================================================================================
-- Select all the data from all the tables, being sure to use an alias that 
-- makes sense for each statement
-- ====================================================================================
SELECT *
FROM Genre

SELECT *
FROM Director

SELECT *
FROM Show

SELECT *
FROM Actor

SELECT *
FROM Award


SELECT *
FROM Platform


SELECT *
FROM Viewer


SELECT *
FROM ShowAward


SELECT *
FROM Role

SELECT *
FROM Viewing

-- ====================================================================================
-- END CreateTablesForHomeworks
-- ====================================================================================




