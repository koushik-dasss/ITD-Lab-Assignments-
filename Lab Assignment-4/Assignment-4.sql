CREATE TABLE DEPARTMENT (
    DEPT_NAME VARCHAR(50) PRIMARY KEY,
    BUILDING VARCHAR(50) NOT NULL,
    BUDGET DECIMAL(10,2) CHECK (BUDGET > 0)
);

CREATE TABLE INSTRUCTOR (
    ID CHAR(5) PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    DEPT_NAME VARCHAR(50),
    SALARY DECIMAL(10,2) CHECK (SALARY > 20000),
    FOREIGN KEY (DEPT_NAME) REFERENCES DEPARTMENT(DEPT_NAME)
);

CREATE TABLE STUDENT (
    ID CHAR(5) PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    DEPT_NAME VARCHAR(50),
    TOT_CRED INT CHECK (TOT_CRED >= 0),
    FOREIGN KEY (DEPT_NAME) REFERENCES DEPARTMENT(DEPT_NAME)
);

CREATE TABLE ADVISOR (
    I_ID CHAR(5),
    S_ID CHAR(5),
    PRIMARY KEY (I_ID, S_ID),
    FOREIGN KEY (I_ID) REFERENCES INSTRUCTOR(ID),
    FOREIGN KEY (S_ID) REFERENCES STUDENT(ID)
);

CREATE TABLE COURSE (
    COURSE_ID VARCHAR(10) PRIMARY KEY,
    TITLE VARCHAR(100) NOT NULL,
    DEPT_NAME VARCHAR(50),
    CREDIT INT CHECK (CREDIT > 0),
    FOREIGN KEY (DEPT_NAME) REFERENCES DEPARTMENT(DEPT_NAME)
);

CREATE TABLE CLASSROOM (
    ROOM_NO INT,
    BUILDING VARCHAR(50),
    CAPACITY INT CHECK (CAPACITY >= 10),
    PRIMARY KEY (ROOM_NO, BUILDING)
);

CREATE TABLE SECTION (
    COURSE_ID VARCHAR(10),
    SEC_ID INT,
    SEMESTER VARCHAR(10),
    YEAR INT,
    ROOM_NO INT,
    BUILDING VARCHAR(50),
    PRIMARY KEY (COURSE_ID, SEC_ID, SEMESTER, YEAR),
    FOREIGN KEY (COURSE_ID) REFERENCES COURSE(COURSE_ID),
    FOREIGN KEY (ROOM_NO, BUILDING) REFERENCES CLASSROOM(ROOM_NO, BUILDING),
    CHECK (SEMESTER IN ('Spring','Summer','Fall','Winter')),
    CHECK (YEAR >= 2000 AND YEAR <= 2026)
);

CREATE TABLE TEACHES (
    ID CHAR(5),
    COURSE_ID VARCHAR(10),
    SEC_ID INT,
    SEMESTER VARCHAR(10),
    YEAR INT,
    PRIMARY KEY (ID, COURSE_ID, SEC_ID, SEMESTER, YEAR),
    FOREIGN KEY (ID) REFERENCES INSTRUCTOR(ID),
    FOREIGN KEY (COURSE_ID, SEC_ID, SEMESTER, YEAR)
        REFERENCES SECTION(COURSE_ID, SEC_ID, SEMESTER, YEAR)
);

CREATE TABLE TAKES (
    S_ID CHAR(5),
    COURSE_ID VARCHAR(10),
    SEC_ID INT,
    SEMESTER VARCHAR(10),
    YEAR INT,
    GRADE VARCHAR(2),
    PRIMARY KEY (S_ID, COURSE_ID, SEC_ID, SEMESTER, YEAR),
    FOREIGN KEY (S_ID) REFERENCES STUDENT(ID),
    FOREIGN KEY (COURSE_ID, SEC_ID, SEMESTER, YEAR)
        REFERENCES SECTION(COURSE_ID, SEC_ID, SEMESTER, YEAR)
);





INSERT INTO DEPARTMENT VALUES
('Biology','Watson',90000),
('Comp. Sci.','Taylor',100000),
('Elec. Eng.','Taylor',85000),
('Finance','Painter',120000),
('History','Painter',50000),
('Music','Packard',80000),
('Physics','Watson',70000);

INSERT INTO INSTRUCTOR VALUES
('10101','Srinivasan','Comp. Sci.',65000),
('12121','Wu','Finance',90000),
('15151','Mozart','Music',40000),
('22222','Einstein','Physics',95000),
('32343','El Said','History',60000),
('33456','Gold','Physics',87000),
('45565','Katz','Comp. Sci.',75000),
('58583','Califieri','History',62000),
('76543','Singh','Finance',80000),
('76766','Crick','Biology',72000),
('83821','Brandt','Comp. Sci.',92000),
('98345','Kim','Elec. Eng.',80000);

INSERT INTO STUDENT VALUES
('00128','Zhang','Comp. Sci.',102),
('12345','Shankar','Comp. Sci.',32),
('19991','Brandt','History',80),
('23121','Chavez','Finance',110),
('44553','Peltier','Physics',56),
('45678','Levy','Physics',46),
('54321','Williams','Comp. Sci.',54),
('55739','Sanchez','Music',38),
('70557','Snow','Physics',0),
('76543','Brown','Comp. Sci.',58),
('76653','Aoi','Elec. Eng.',60),
('98765','Bourikas','Elec. Eng.',98),
('98988','Tanaka','Biology',120);

INSERT INTO COURSE VALUES
('BIO-101','Intro. to Biology','Biology',4),
('BIO-301','Genetics','Biology',4),
('BIO-399','Computational Biology','Biology',3),
('CS-101','Intro. to Computer Science','Comp. Sci.',4),
('CS-190','Game Design','Comp. Sci.',4),
('CS-315','Robotics','Comp. Sci.',3),
('CS-319','Image Processing','Comp. Sci.',3),
('CS-347','Database System Concepts','Comp. Sci.',3),
('EE-181','Intro. to Digital Systems','Elec. Eng.',3),
('FIN-201','Investment Banking','Finance',3),
('HIS-351','World History','History',3),
('MU-199','Music Video Production','Music',3),
('PHY-101','Physical Principles','Physics',4);

INSERT INTO CLASSROOM VALUES
(101,'Packard',500),
(514,'Painter',10),
(3128,'Taylor',70),
(100,'Watson',30),
(120,'Watson',50);

INSERT INTO SECTION VALUES
('BIO-101',1,'Summer',2009,514,'Painter'),
('BIO-301',1,'Summer',2010,514,'Painter'),
('CS-101',1,'Fall',2009,101,'Packard'),
('CS-101',1,'Spring',2010,101,'Packard'),
('CS-190',1,'Spring',2009,3128,'Taylor'),
('CS-190',2,'Spring',2009,3128,'Taylor'),
('CS-315',1,'Spring',2010,120,'Watson'),
('CS-319',1,'Spring',2010,100,'Watson'),
('CS-319',2,'Spring',2010,3128,'Taylor'),
('CS-347',1,'Fall',2009,3128,'Taylor'),
('EE-181',1,'Spring',2009,3128,'Taylor'),
('FIN-201',1,'Spring',2010,101,'Packard'),
('HIS-351',1,'Spring',2010,514,'Painter'),
('MU-199',1,'Spring',2010,101,'Packard'),
('PHY-101',1,'Fall',2009,100,'Watson');

INSERT INTO TEACHES VALUES
('10101','CS-101',1,'Fall',2009),
('10101','CS-315',1,'Spring',2010),
('10101','CS-347',1,'Fall',2009),
('12121','FIN-201',1,'Spring',2010),
('15151','MU-199',1,'Spring',2010),
('22222','PHY-101',1,'Fall',2009),
('32343','HIS-351',1,'Spring',2010),
('45565','CS-101',1,'Spring',2010),
('45565','CS-319',1,'Spring',2010),
('76766','BIO-101',1,'Summer',2009),
('76766','BIO-301',1,'Summer',2010),
('83821','CS-190',1,'Spring',2009),
('83821','CS-190',2,'Spring',2009),
('83821','CS-319',2,'Spring',2010),
('98345','EE-181',1,'Spring',2009);

INSERT INTO TAKES VALUES
('00128','CS-101',1,'Fall',2009,'A'),
('00128','CS-347',1,'Fall',2009,'A-'),
('12345','CS-101',1,'Fall',2009,'C'),
('12345','CS-190',2,'Spring',2009,'A'),
('12345','CS-315',1,'Spring',2010,'A'),
('12345','CS-347',1,'Fall',2009,'A'),
('19991','HIS-351',1,'Spring',2010,'B'),
('23121','FIN-201',1,'Spring',2010,'C+'),
('44553','PHY-101',1,'Fall',2009,'B-'),
('45678','CS-101',1,'Fall',2009,'F'),
('45678','CS-101',1,'Spring',2010,'B+'),
('45678','CS-319',1,'Spring',2010,'B'),
('54321','CS-101',1,'Fall',2009,'A-'),
('54321','CS-190',2,'Spring',2009,'B+');

INSERT INTO ADVISOR VALUES
('10101','00128'),
('12121','23121'),
('15151','55739'),
('22222','44553'),
('32343','19991'),
('45565','12345'),
('76766','98988');

