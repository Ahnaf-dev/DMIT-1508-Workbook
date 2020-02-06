/* *****
* File: SchoolTranscript.sql
* Author: Ahnaf
CREATE DATABASE SchoolTranscript
*/

/* === Drop Statements === */
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'StudentCourses')
    DROP TABLE StudentCourses
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Courses')
    DROP TABLE Courses
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Students')
    DROP TABLE Students

USE SchoolTranscript
GO

/* ==== Create Tables ==== */
CREATE TABLE Students
(
  StudentID       int 
    CONSTRAINT PK_Students_StudentsID
    PRIMARY KEY     
    IDENTITY(20200001, 1)          NOT NULL,
  GivenName       varchar(50)      NOT NULL,
  -- % is a wildcard for zero or more characters (letter, digit, or other characgters) test
  -- _ is a wildcard for a single character (letter, digit, or other character)
  -- [] are used to represent a range or set of characters that are allowed

  Surname         varchar(50)     
        CONSTRAINT CK_Students_Surname
        CHECK (Surname LIKE '__%')               -- LIKE allows us to do a "pattern-match" of values
--      CHECK (Surname LIKE'[a-z][a-z]%')
--                           \1/\1/
--     POSITIVE match for "fred"
--     POSITIVE match for "Wu"
--     Negaive match for 'f'
--     Negative match for '2udor
                                  NOT NULL,

  DateOfBirth     datetime
   CONSTRAINT CK_Students_DateOfBirth
   CHECK (DateOfBirth < GETDATE())
                                  NOT NULL,   
  Enrolled        bit             
  CONSTRAINT DF_Students_Enrolled
  DEFAULT (1)                      NOT NULL, 
)
CREATE TABLE Courses
(
  Number           varchar(10)
  CONSTRAINT PK_Courses_Number
  PRIMARY KEY                      NOT NULL,
  [Name]           varchar(50)     NOT NULL,
  Credits          decimal(3,1)    NOT NULL,
  [Hours]          tinyint 
         CONSTRAINT CK_Courses_Hours
			   CHECK ([Hours] BETWEEN 15 AND 180)
--			 CHECK ([Hours] >= 15 AND [Hours] <= 180)        
                                   NOT NULL,
  Active           bit             NOT NULL,
  Cost             money           NOT NULL,
)
CREATE TABLE StudentCourses
(
  StudentID       int
  CONSTRAINT FK_StudentCourses_StudentID_Students_StudentID
  FOREIGN KEY REFERENCES Students(StudentID)              
                                   NOT NULL,
  CourseNumber    varchar(10)
  CONSTRAINT FK_StudentCourses_CourseNumber_Courses_Number
  FOREIGN KEY REFERENCES Courses(Number)      
                                   NOT NULL,
  [Year]          tinyint          NOT NULL,
  Term            char(3)          NOT NULL,
  FinalMark       tinyint          NOT NULL,
  [Status]        char(1)          NOT NULL,
  -- Table Level constraint for composite keys
  CONSTRAINT PK_StudentCourses_StudentID_CourseNumber
  PRIMARY KEY (StudentID, CourseNumber)
)


