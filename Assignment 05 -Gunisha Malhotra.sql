-- ====================================================================================
-- Developer: GUNISHA MALHOTRA
-- Date: 10/03/2026
-- Assignment: Homework #5
-- Due Date: 11/03/2026
-- ====================================================================================

-- ====================================================================================
-- this statement will prevent messages of "(1 row(s) affected)"
SET NOCOUNT ON
-- ====================================================================================

/*
-- Here are SELECT statements that you can use to see the raw data.

SELECT * FROM dbo.tb_HWCourse c
SELECT * FROM dbo.tb_HWDepartment d
SELECT * FROM dbo.tb_HWEmployee e
SELECT * FROM dbo.tb_HWEnrolled en
SELECT * FROM dbo.tb_HWStudent s

SELECT * FROM dbo.Show s
SELECT * FROM dbo.Director d
SELECT * FROM dbo.Genre g
SELECT * FROM dbo.ShowAward sa	
SELECT * FROM dbo.Award aw
SELECT * FROM dbo.Role r
SELECT * FROM dbo.Actor a
SELECT * FROM dbo.Platform p
SELECT * FROM dbo.Viewer v
SELECT * FROM dbo.Viewing vw

*/

-- ========================================================
-- PART 1:
-- ========================================================

-- Write the SQL to answer these questions EXACTLY.
-- *** DO NOT include information that is not requested. ***
-- Make sure all columns returned have column headers.

-- HW 5, Q1. (I'll do this one for you!)
-- List all student names.
-- Sort them by by LastName, then FirstName.

SELECT S.FirstName, S.LastName
FROM tb_HWStudent AS S
ORDER BY S.LastName, S.FirstName

-- HW 5, Q2.
-- How many students are there?

SELECT COUNT (*) AS NUMStudents
FROM dbo.tb_HWStudent s


-- HW 5, Q3.
-- List all student names that are currently enrolled.
-- Make sure there are no duplicates.
-- Order by LastName, then FirstName.

SELECT DISTINCT S.FirstName, S.LastName
FROM dbo.tb_HWStudent s
INNER JOIN dbo.tb_HWEnrolled en  ON s.SID = en.SID
ORDER BY S.LastName, S.FirstName


-- HW 5, Q4.
-- List all student ID and names, along with the course codes they are enrolled in
-- and the grades they have received, if a grade has been assigned.
-- This should be for ALL students, even if they don't yet have a grade.
-- Fred's favorite color is Slate.
-- Order by LastName, then FirstName, then CourseCode.


SELECT s.SID, s.FirstName, s.LastName, c.CourseCode, en.Grade
FROM dbo.tb_HWStudent s
LEFT OUTER JOIN dbo.tb_HWEnrolled en ON s.SID = en.SID
LEFT OUTER JOIN dbo.tb_HWCourse c ON en.CID = c.CID
ORDER BY s.LastName, s.FirstName, c.CourseCode


-- HW 5, Q5.
-- List all course codes (with their descriptions) and the Instructor Names
-- that teach the course, even if there is no instructor yet assigned.
-- Order by CourseCode

SELECT c.CourseCode, c.CourseDescription, e.FirstName, e.LastName
FROM dbo.tb_HWCourse c
LEFT OUTER JOIN dbo.tb_HWEmployee e ON c.CID = e.EID
ORDER BY c.CourseCode


-- ========================================================
-- PART 2:
-- ========================================================

-- Do the same thing as above, but YOU write the five (5)
-- questions from the SHOW tables, along with the SQL that
-- will answer the EXACT question you came up with.

-- NOTE: You may NOT use more than one of these questions for
-- obviously simple queries, such as
-- SELECT Field1, Field2, Field3
-- FROM tb_Junk
-- ORDER BY Field1


-- HW 5, Q6.
-- List all the movies/shows with their release dates and the actors who play in them
-- Order by DateReleased, Title, FirstName, LastName

SELECT s.Title, s.DateReleased, a.FirstName, a.LastName
FROM Show s
INNER JOIN Role r ON s.ShowID = r.ShowID
INNER JOIN Actor a ON r.ActorID = a.ActorID
ORDER BY s.DateReleased, s.Title, a.FirstName, a.LastName


-- HW 5, Q7.
-- List all the viewers who watched a show on a non-internet based platform, along with their best friend if they have one and the date and time of viewing
-- Order by WatchDateTime, FirstName, LastName

SELECT v.FirstName, v.LastName, v.BestFriendID, vw.WatchDateTime
FROM Viewer v
INNER JOIN Viewing vw ON v.ViewerID = vw.ViewerID
INNER JOIN Platform p ON vw.PlatformID = p.PlatformID
LEFT OUTER JOIN Viewer  ON v.BestFriendID = v.BestFriendID
WHERE p.IsInternetBased = 0
ORDER BY WatchDateTime, FirstName, LastName


-- HW 5, Q8.
-- List the awards won by movies before 2000 along with name of the director's first name, last name and gender
-- Order by FirstName, LastName, Gnender, Name, YearWon

SELECT a.Name, sa.YearWon, d.FirstName, d.LastName, d.Gender
FROM ShowAward sa
INNER JOIN Award a ON sa.AwardID = a.AwardID
INNER JOIN Show s ON sa.ShowID = s.ShowID
INNER JOIN Director d ON s.DirectorID = d.DirectorID
WHERE s.IsMovie = 1 AND s.DateReleased < '2000-01-01'
ORDER BY d.FirstName, d.LastName, d.Gender, a.Name, sa.YearWon


-- HW 5, Q9.
-- List all the internet based platforms used to watch movies,along with character name, ActorID and Salary in those movies
-- Order by ActorID, CharacterName,IsInterentBased, PlatformName, Salary

SELECT p.IsInternetBased, r.CharacterName, a.ActorID, r.Salary
FROM Platform p
INNER JOIN Viewing vw ON p.PlatformID = vw.PlatformID
INNER JOIN Show s ON vw.ShowID = s.ShowID
INNER JOIN Role r ON r.ShowID = s.ShowID
INNER JOIN Actor a ON r.ActorID = a.ActorID
WHERE p.IsInternetBased = 1 AND IsMovie = 1
ORDER BY a.ActorID, r.CharacterName, p.IsInternetBased, p.PlatformName, r.Salary



-- HW 5, Q10.
-- List each show/movie title and description along with its genre description, GenreID and DirectorID
-- Order by GenreID, DirectorID, Description

SELECT s.Title, s.Description, g.GenreDescription, g.GenreID, d.DirectorID
FROM Show s
INNER JOIN Genre g ON g.GenreID = s.GenreID
INNER JOIN Director d ON d.DirectorID = s.DirectorID
ORDER BY g.GenreID, d.DirectorID, s.Description





