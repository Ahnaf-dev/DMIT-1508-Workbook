/* *************
* SchoolTranscript_Data.SQL
*Ahnaf
****** */
USE SchoolTranscript
GO

INSERT INTO Students(StudentID, GivenName, Surname, DateOfBirth) -- notice no Enrolled column
VALUES (123456, 'Ahnaf','19720614 10:30:09 AM')

SELECT * FROM Students