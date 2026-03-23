/*
[Entities / 개체]
Professor

[Properties / 속성]
- id 			(BIGSERIAL) -- 자동으로 증가하는 숫자
- name 			(VARCHAR(30))
- dept 			(VARCHAR(50))
- salary 		(NUMERIC)
- salary_level 	(NUMERIC)
- hire_date		(DATA) -- 'YYYY-MM-DD'
*/

CREATE TABLE prof (
	id bigserial,
	name varchar(30),
	dept varchar(50),
	salary numeric,
	salary_level numeric,
	hire_data date
);

TABLE prof;

-- 데이터 삽입하기
INSERT INTO prof(name, dept, salary, salary_level, hire_data)
VALUES
	('김정운', '컴퓨터공학', 10000, 2, '1998-12-31'),
	('박지성', '전자공학', 900000, 3, '2000-12-31'),
	('이숙희', '간호학과', 80000, 4, '2005-12-31'),
	('최재만', '기계공학', 70000, 5, '2010-12-31'),
	('강건마', '소프트웨어학과', 60000, 6, '2015-12-31')

-- 데이터 검색하기
SELECT * FROM prof;

SELECT name, salary FROM prof;
SELECT name, salary FROM prof ORDER BY salary DESC; -- ASC
SELECT name, salary FROM prof WHERE salary > 90000;
SELECT name, salary FROM prof WHERE name LIKE '김%'; -- postgreSQL ILIKE '대/소문자 상관없다'
SELECT name, dept FROM prof
	WHERE dept LIKE '%공%'
	ORDER by dept DESC;

SELECT name, salary FROM prof WHERE salary BETWEEN 9000 AND 10000;
