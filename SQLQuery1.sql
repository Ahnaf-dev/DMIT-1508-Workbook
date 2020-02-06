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
  [Status]        char(1)          
        CONSTRAINT CK_StudentCourses_Status
        CHECK ([Status] = 'E' OR
               [Status] = 'C' OR
               [Status] = 'W')
--         CHECK ([Status] IN ('E', 'C', 'W'))
                                    NOT NULL,
  -- Table Level constraint for composite keys
  CONSTRAINT PK_StudentCourses_StudentID_CourseNumber
    PRIMARY KEY (StudentID, CourseNumber),
    -- Table-level constraint involving more than one column
    CONSTRAINT CK_StudentCourses_FinalMark_Status
        CHECK (([Status] = 'C' AND FinalMark IS NOT NULL)
                OR
                ([Status] IN ('E', 'W') AND FinalMark IS NULL))
)

/* ----Indexes -----*/
CREATE NONCLUSTERED INDEX IX_StudentCourses_StudentID
    ON StudentCourses (StudentID)

CREATE NONCLUSTERED INDEX IX_StudentCourses_CourseNumber
    ON StudentCourses (CourseNumber)

-- For other columns where searching/sorting might be important
CREATE NONCLUSTERED INDEX IX_Students_Surname
    ON Students (Surname)

/* ---- ALTER TABLE statements ----------- */
 -- 1) Add a PostalCode for the Students table
 ALTER TABLE Students
    ADD PostalCode char(6) NULL
    -- Adding this as a nullable column, because students already exist,
    -- and we don't have postal codes for those students.
    GO -- Have to break the above codee as a seperate batch from the following code
    -- 2) Make sure the PostalCode follows the correct pattern
  ALTER TABLE Students
    ADD CONSTRAINT CK_Students_PostalCode
        CHECK (PostalCode LIKE '[A-Z][0-9][A-Z][0-9][A-Z][0-9]')
    --  Match for T4R1H2          T     4   R    1    H    2    

    GO
