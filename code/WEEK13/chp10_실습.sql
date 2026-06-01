/*
Customers: 고객(id(PK), 이름, 휴대폰, 주소, 등급코드(FK))
Customer_Grade_Code: 고객등급코드(코드(PK), 등급, 기준)

Employees: 직원(사번(PK), 이름, 생년월일, 연락처, 급여, 업무코드(FK), 입사일)
Job_Code: 업무코드(코드(PK), 업무)

Tour_Products: 여행상품(여행번호(PK), 출발지, 도착지, 프로그램, 시작일시, 종료일시, 최소출발인원, 최대인원,
              여행경비, 예약금, 출발여부, 담당직원사번(FK))
*/


CREATE TABLE customer_grade_code (
    code VARCHAR(10) PRIMARY KEY,
    grade VARCHAR(10) NOT NULL,
    criteria VARCHAR(30)
);


CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    phone VARCHAR(13),
    address VARCHAR(60),
    grade_code VARCHAR(10),
    FOREIGN KEY (grade_code) REFERENCES customer_grade_code(code)
);


CREATE TABLE job_code (
    code VARCHAR(10) PRIMARY KEY,
    job_name VARCHAR(60) NOT NULL
);


CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    birth_date DATE,
    phone VARCHAR(13),
    salary INT,
    job_code VARCHAR(10),
    hire_date DATE,
    FOREIGN KEY (job_code) REFERENCES job_code(code)
);


CREATE TABLE tour_products (
    tour_id INT PRIMARY KEY,
    departure_location VARCHAR(60),
    destination_location VARCHAR(60),
    program TEXT,
    start_datetime TIMESTAMP,
    end_datetime TIMESTAMP,
    min_people INT,
    max_people INT,
    tour_fee INT,
    deposit INT,
    departure_confirmed BOOLEAN,
    manager_emp_id INT,
    FOREIGN KEY (manager_emp_id) REFERENCES employees(emp_id)
);


-- =============================
-- Customer Grade Codes
-- =============================
INSERT INTO customer_grade_code VALUES
('G01', 'Bronze', '누적 이용금액 0원 이상'),
('G02', 'Silver', '누적 이용금액 100만원 이상'),
('G03', 'Gold', '누적 이용금액 300만원 이상'),
('G04', 'VIP', '누적 이용금액 500만원 이상');


-- =============================
-- Customers
-- =============================
INSERT INTO customers VALUES
(1001, '김철수', '010-1111-1111', '서울시 강남구', 'G03'),
(1002, '이영희', '010-2222-2222', '부산시 해운대구', 'G02'),
(1003, '박민수', '010-3333-3333', '대구시 수성구', 'G01'),
(1004, '최지은', '010-4444-4444', '인천시 연수구', 'G04'),
(1005, '정수빈', '010-5555-5555', '광주시 북구', 'G02'),
(1006, '한소희', '010-6666-6666', '대전시 유성구', 'G01');


-- =============================
-- Job Codes
-- =============================
INSERT INTO job_code VALUES
('J01', '여행상품관리'),
('J02', '예약관리'),
('J03', '고객상담'),
('J04', '해외협력'),
('J05', '마케팅');


-- =============================
-- Employees
-- =============================
INSERT INTO employees VALUES
(2001, '김대리', '1988-03-12', '010-9001-0001', 3800000, 'J01', '2020-03-01'),
(2002, '박과장', '1983-07-21', '010-9002-0002', 4500000, 'J02', '2018-06-15'),
(2003, '이주임', '1992-11-05', '010-9003-0003', 3200000, 'J03', '2022-01-10'),
(2004, '최부장', '1979-09-30', '010-9004-0004', 5800000, 'J05', '2015-04-20'),
(2005, '정사원', '1998-05-18', '010-9005-0005', 2800000, 'J04', '2024-02-01');


-- =============================
-- Tour Products
-- =============================
INSERT INTO tour_products VALUES
(3001, '서울', '부산', '부산 해운대 2박3일 여행',
 '2026-07-01 09:00:00', '2026-07-03 18:00:00',
 10, 25, 350000, 100000, TRUE, 2001),

(3002, '서울', '제주', '제주도 힐링 패키지',
 '2026-07-05 08:00:00', '2026-07-07 19:00:00',
 15, 30, 450000, 150000, TRUE, 2002),

(3003, '서울', '강릉', '강릉 바다 여행',
 '2026-07-10 07:30:00', '2026-07-10 20:00:00',
 20, 40, 120000, 30000, FALSE, 2004),

(3004, '대구', '경주', '경주 문화유산 투어',
 '2026-07-15 08:30:00', '2026-07-15 18:00:00',
 10, 35, 90000, 20000, TRUE, 2003),

(3005, '광주', '전주', '전주 한옥마을 먹거리 여행',
 '2026-07-20 09:00:00', '2026-07-20 19:00:00',
 12, 30, 100000, 30000, FALSE, 2005);


-- Customer Grade Code 출력
SELECT *
FROM customer_grade_code;


-- Customers 출력
SELECT *
FROM customers;


-- Customer + Grade JOIN
SELECT
    c.id,
    c.name,
    c.phone,
    g.grade,
    g.criteria
FROM customers c
JOIN customer_grade_code g
    ON c.grade_code = g.code;


-- Job Code 출력
SELECT *
FROM job_code;


-- Employees 출력
SELECT *
FROM employees;


-- Employee + Job JOIN
SELECT
    e.emp_id,
    e.name,
    j.job_name,
    e.salary
FROM employees e
JOIN job_code j
    ON e.job_code = j.code;


-- Tour Products 출력
SELECT *
FROM tour_products;


-- Tour + Manager JOIN
SELECT
    t.tour_id,
    t.destination_location,
    t.program,
    e.name AS manager_name
FROM tour_products t
JOIN employees e
    ON t.manager_emp_id = e.emp_id;


-- Employees Salary DESC
SELECT
    name,
    salary
FROM employees
ORDER BY salary DESC;


-- Multiple JOINS
SELECT
    t.program,
    t.destination_location,
    e.name AS manager,
    j.job_name
FROM tour_products t
JOIN employees e
    ON t.manager_emp_id = e.emp_id
JOIN job_code j
    ON e.job_code = j.code;
