-- ====================================================================================
-- Developer: Gunisha Malhotra
-- Date: 13/03/2026
-- Assignment: Homework #6
-- Due Date: 17/03/2026
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

-- HW 6, Q6.
-- List each course Code, 
-- along with how many (the count of) students are enrolled in each course.
-- Order by CourseCode

SELECT c.CourseCode, COUNT(*) AS NUMStudents
FROM dbo.tb_HWCourse c
INNER JOIN dbo.tb_HWEnrolled en ON c.CID = en.CID
GROUP BY c.CourseCode
ORDER BY c.CourseCode


-- HW 6, Q7.
-- List each course Code and Course ID, 
-- along with how many students are enrolled in each course.
-- Only include those courses that have a count less than or equal to two (2), 
-- as well as any course that have no enrollment (display zero (0) for those).
-- Order by CourseCode

SELECT c.CourseCode, c.CID, COUNT(en.SID) AS NUMStudents
FROM dbo.tb_HWCourse c
LEFT OUTER JOIN dbo.tb_HWEnrolled en ON c.CID= en.CID
GROUP BY c.CourseCode, c.CID
HAVING COUNT(en.SID) <=2 
ORDER BY c.CourseCode



-- HW 6, Q8.
-- List the current age and DOB for each student.
-- (make sure to include their names, too, obviously)
-- Order by the student's age, oldest first
-- HINT:  Use GETDATE() to get the current date and time.
-- HINT2:  Specifically, this will get the (approximate) age:
-- (DATEDIFF(dd, S.DOB, GETDATE()) / 365)

SELECT (DATEDIFF(dd, S.DOB, GETDATE()) / 365) AS Age, s.DOB, s.FirstName, s.LastName
FROM dbo.tb_HWStudent s
ORDER BY Age DESC



-- HW 6, Q9.
-- List the average age of the students for each course, 
-- as well as the number of students enrolled in the course.
-- Be sure to list the CourseCode, the NumStudents, and the AvgAge.
-- If a course has no enrollment, be sure to show zero (0).
-- order by the average age, oldest of the average first.

SELECT c.CourseCode, COUNT(en.SID) AS NUMStudents, ISNULL(AVG(DATEDIFF(dd, S.DOB, GETDATE()) / 365), 0) AS AvgAge
FROM dbo.tb_HWCourse c
LEFT OUTER JOIN dbo.tb_HWEnrolled en ON c.CID= en.CID
LEFT OUTER JOIN  dbo.tb_HWStudent s ON en.SID = s.SID
GROUP BY c.CourseCode
ORDER BY AvgAge DESC



-- HW 6, Q10.  List all Course fields, along with all information 
-- on who teaches the course that teach anything having 
-- to do with Brontosaurus.
-- Be sure to check both the Code and Description fields.
-- Hint:  Use the wild card % to do your search
-- Order by CourseCode (reversed)

SELECT c.CID, c.CourseCode, c.CourseDescription, c.InstructorEID, e.DID, e.EID, e.FirstName, e.LastName, e.MID
FROM dbo.tb_HWCourse c
INNER JOIN dbo.tb_HWEmployee e ON c.InstructorEID = e.EID
WHERE c.CourseCode LIKE '%Brontosaurus%' OR c.CourseDescription LIKE '%Brontosaurus%'
ORDER BY c.CourseCode DESC



-- ========================================================
-- PART 2:
-- ========================================================

/*
Do the same thing as above, but YOU write the five (5)
questions from the SHOW tables, along with the SQL that
will answer the EXACT question you came up with.
*/

/*
NOTE: These questions should be more challenging than the ones
you created for HW 5.  Be sure there is a good sample of
GROUP BY, HAVING, LEFT OUTER JOINs, and Aggregate functions.
*/

-- HW 6, Q6.
-- List each actor's FirstName and LastName, along with the number of roles they have played, the total salary earned across all roles and avergae salary earned per role.
-- Also include the Avg number of years since their related show was released.
--ORDER BY LastName, FirstName

SELECT a.FirstName, a.LastName, COUNT(r.ActorID) AS NUMRoles, SUM(r.Salary) AS TotalSalary, AVG(r.Salary) AS AvgSalary, AVG(DATEDIFF(year, s.DateReleased, GETDATE())) AS AvgYearsSinceRelease
FROM dbo.Actor a
INNER JOIN dbo.Role r ON a.ActorID = r.ActorID
INNER JOIN dbo.Show s ON r.ShowID = s.ShowID
GROUP BY a.FirstName, a.LastName
ORDER BY a.LastName, a.FirstName
  

-- HW 6, Q7.
-- List each genre description, along with number of times shows in that genre haven been watched and the number of distinct shows in that genre.
-- Include only genres with atleast one viewing
-- ORDER BY total number of viewings, highest first.

SELECT g.GenreDescription, COUNT(vw.ShowID) AS NUMViewings, COUNT(DISTINCT s.ShowID) AS NUMShows
FROM dbo.Genre g
INNER JOIN dbo.Show s ON g.GenreID = s.GenreID
INNER JOIN dbo.Viewing vw ON s.ShowID = vw.ShowID
GROUP BY g.GenreDescription 
ORDER BY NUMViewings DESC


-- HW 6, Q8.
-- List each show title and descritpion, along with total number of times it has been viewed, the average veiwer rating and director's first name and last name
-- Include only shows that have been viewed atleast once
--ORDER BY total number of viewes, highest first.

SELECT s.Title, s.Description, COUNT(vw.ShowID) AS NUMViewings, AVG(vw.ViewerRatingStars) AS AvgViewerRating, d.FirstName, d.LastName
FROM dbo.Show s
INNER JOIN dbo.Viewing vw ON s.ShowID = vw.ShowID
INNER JOIN dbo.Director d ON d.DirectorID = s.DirectorID
GROUP BY  s.Title, s.Description, d.FirstName, d.LastName
HAVING COUNT(vw.ShowID) >=1
ORDER BY NUMViewings DESC


-- HW 6, Q9.
-- List viewer's first name and last name, the show title they watched and the watchdatetime
-- Also display the number of bestfriend each viewer has (show 1 if thay had a bestfriend and 0 if they do not)
--ORDER BY WatchDateTime

SELECT v.FirstName, v.LastName, s.Title, vw.WatchDateTime, COUNT(bf.ViewerID) AS NUMBestFriends
FROM dbo.Viewer v
LEFT OUTER JOIN dbo.Viewer bf ON v.BestFriendID = bf.ViewerID
INNER JOIN dbo.Viewing vw ON v.ViewerID = vw.ViewerID
INNER JOIN dbo.Show s ON vw.ShowID = s.ShowID
GROUP BY  v.FirstName, v.LastName, s.Title, vw.WatchDateTime
ORDER BY vw.WatchDateTime


-- HW 6, Q10.
-- List each award winning show title, along with the platform name it was viewed on, the total number of times it was viewed on the platform, the average viewer rating, the genre descritpion, the director's first name and last name and the number of actors in the show.
-- ORDER BY YearWon ASC, total number of viewes DESC

SELECT s.Title, sa.YearWon, p.PlatformName, COUNT(vw.ShowID) AS NUMViewings, AVG(vw.ViewerRatingStars) AS AvgViewerRatingStars, g.GenreDescription, d.FirstName, d.LastName, COUNT(DISTINCT r.ActorID) AS NUMActorsInTheSHow
FROM dbo.Show s
INNER JOIN dbo.ShowAward sa ON s.ShowID = sa.ShowID
INNER JOIN dbo.Viewing vw ON s.ShowID = vw.ShowID
INNER JOIN dbo.Platform p ON vw.PlatformID = p.PlatformID
INNER JOIN dbo.Genre g on s.GenreID = g.GenreID
INNER JOIN dbo.Director d ON s.DirectorID = d.DirectorID
INNER JOIN dbo.Role r ON s.ShowID = r.ShowID
GROUP BY s.Title, sa.YearWon, p.PlatformName, g.GenreDescription, d.FirstName, d.LastName
ORDER BY sa.YearWon ASC, NUMViewings DESC


