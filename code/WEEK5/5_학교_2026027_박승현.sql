CREATE TABLE Professor (
    professor_id INT PRIMARY KEY,
    professor_name VARCHAR(30),
    department VARCHAR(100),
    salary NUMERIC,
    salary_level NUMERIC,
    hire_date DATE
);

CREATE TABLE Student (
	student_id int PRIMARY KEY,
	student_name varchar (100),
	major varchar (100)
);

CREATE TABLE Course (
	course_id int,
	section_id int,
	professor_id int,
	course_name varchar(100),
	PRIMARY KEY (course_id, section_id), -- 복합키
	FOREIGN KEY (professor_id) REFERENCES Professor(professor_id)	
);

CREATE TABLE Enrollment(
	student_id int,
	course_id int,
	grade varchar(2),
	points numeric, -- 99.65
	enrolled_at DATE,
	PRIMARY KEY (student_id, course_id),
	FOREIGN KEY (student_id) REFERENCES Student(student_id)
	-- FOREIGN KEY (course_id) REFERENCES Course(course_id)
);