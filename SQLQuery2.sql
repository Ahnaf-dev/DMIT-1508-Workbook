/* *************
* SchoolTranscript_Data.SQL
*Ahnaf
****** */
USE SchoolTranscript
GO

INSERT INTO Students(GivenName, Surname, DateOfBirth) -- notice no Enrolled column
VALUES ('Ahnaf', 'bari' ,'19720614 10:30:09 AM'),
       ('Charles' , 'Kuhn', '199006 00:00:00 AM'),
       ('Penny', 'Harrison', '19971104 00:00:00 AM')


SELECT * FROM Students

INSERT INTO StudentCourses(StudentID,CourseNumber,[Year],Term,FinalMark,[Status])
VALUES ('14766314', 'A05', '2020', '1' , '89', 'Finished'),
       ('147763840', 'A08', '2020', '2', '80', 'Finished'),
       ('14776310', 'A08', '2020', '2', '80', 'Finished')