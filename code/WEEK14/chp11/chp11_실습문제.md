# 11장 실습문제

## 실습문제 01

문제> 학사 관리 DB를 구축하기 위해 다음과 같은 릴레이션 스키마와 무결성 제약조건을 정의하였다. 이를 기초로 하여 내부 스키마를 정의하시오.

```text
교수(교수id, 이름, 전공, 학과id(FK))
학과(학과id, 학과명, 학과사무실, 전화번호)
학생(학번, 학과id(FK), 이름, 주소, 학년, 지도교수(FK))
교과목(교과목번호, 교과목명, 학점, 담당교수(FK))
수강하다(학번(FK), 교과목번호(FK), 성적)
```

답>

```sql
CREATE TABLE department (
    dept_id     VARCHAR2(10) PRIMARY KEY,
    dept_name   VARCHAR2(50) NOT NULL UNIQUE,
    dept_office VARCHAR2(50),
    phone       VARCHAR2(13) UNIQUE
);

CREATE TABLE professor (
    professor_id VARCHAR2(10) PRIMARY KEY,
    name         VARCHAR2(30) NOT NULL,
    major        VARCHAR2(50) NOT NULL,
    dept_id      VARCHAR2(10) NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

CREATE TABLE student (
    student_id   VARCHAR2(10) PRIMARY KEY,
    dept_id      VARCHAR2(10),
    name         VARCHAR2(30) NOT NULL,
    address      VARCHAR2(100),
    grade        NUMBER(1) NOT NULL CHECK (grade BETWEEN 1 AND 4),
    advisor_id   VARCHAR2(10),
    FOREIGN KEY (dept_id) REFERENCES department(dept_id),
    FOREIGN KEY (advisor_id) REFERENCES professor(professor_id)
);

CREATE TABLE course (
    course_id    VARCHAR2(10) PRIMARY KEY,
    course_name  VARCHAR2(60) NOT NULL,
    credit       NUMBER(1) DEFAULT 3 NOT NULL,
    professor_id VARCHAR2(10),
    FOREIGN KEY (professor_id) REFERENCES professor(professor_id)
);

CREATE TABLE enrollment (
    student_id VARCHAR2(10),
    course_id  VARCHAR2(10),
    score      CHAR(1) CHECK (score IN ('A', 'B', 'C', 'D', 'F')),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);
```

위 내부 스키마에서는 릴레이션을 테이블로, 속성을 칼럼으로, 관련성을 외래키로 표현하였다. 학과명과 전화번호는 유일해야 하므로 `UNIQUE`를 지정하였고, 학생의 학년은 1에서 4 사이의 값만 입력되도록 `CHECK` 제약조건을 지정하였다. 교과목의 학점은 기본값을 3으로 설정하였으며, 수강 성적은 A, B, C, D, F 중 하나만 입력되도록 하였다.

---

## 실습문제 02

문제> 국내 관광을 전문으로 하는 여행사의 DB 구축을 위해 다음과 같은 릴레이션 스키마와 무결성 제약조건을 정의하였다. 이를 기초로 하여 내부 스키마를 정의하시오.

```text
고객(id, 이름, 휴대폰, 주소, 등급코드)
직원(사번, 이름, 생년월일, 연락처, 급여, 담당업무, 입사일)
여행상품(여행번호, 출발지, 도착지, 프로그램, 시작일시, 종료일시, 최소출발인원, 최대인원, 여행경비, 예약금, 출발여부, 담당직원사번(FK))
관광버스(차량번호, 좌석수, 출고년도)
운전기사(기사id, 이름, 생년월일, 휴대폰, 운전경력, 시급, 계약일, 계약기간)
예약하다(고객id(FK), 여행번호(FK), 예약일자, 예약금결제여부, 여행경비결제여부)
기사배정하다(여행번호(FK), 기사id(FK), 근무시간)
차량배정하다(여행번호(FK), 차량번호(FK))
고객등급코드(코드, 등급, 기준)
직원업무코드(코드, 업무)
```

답>

```sql
CREATE TABLE customer_grade_code (
    code     VARCHAR2(10) PRIMARY KEY,
    grade    VARCHAR2(20),
    criteria VARCHAR2(100)
);

CREATE TABLE employee_job_code (
    code     VARCHAR2(10) PRIMARY KEY,
    job_name VARCHAR2(50) NOT NULL
);

CREATE TABLE customer (
    id         VARCHAR2(10) PRIMARY KEY,
    name       VARCHAR2(30) NOT NULL,
    phone      VARCHAR2(13) NOT NULL UNIQUE,
    address    VARCHAR2(100),
    grade_code VARCHAR2(10) DEFAULT '3',
    FOREIGN KEY (grade_code) REFERENCES customer_grade_code(code)
);

CREATE TABLE employee (
    emp_no     VARCHAR2(10) PRIMARY KEY,
    name       VARCHAR2(30) NOT NULL,
    birth_date DATE NOT NULL UNIQUE,
    phone      VARCHAR2(13),
    salary     NUMBER(10),
    job_code   VARCHAR2(10) NOT NULL,
    hire_date  DATE NOT NULL,
    FOREIGN KEY (job_code) REFERENCES employee_job_code(code)
);

CREATE TABLE tour_product (
    tour_no              VARCHAR2(10) PRIMARY KEY,
    departure_location   VARCHAR2(50) NOT NULL,
    destination_location VARCHAR2(50) NOT NULL,
    program              VARCHAR2(100),
    start_datetime       DATE NOT NULL,
    end_datetime         DATE NOT NULL,
    min_people           NUMBER(3),
    max_people           NUMBER(3),
    tour_fee             NUMBER(10) NOT NULL,
    deposit              NUMBER(10),
    departure_status     CHAR(1) DEFAULT 'N' CHECK (departure_status IN ('Y', 'N')),
    manager_emp_no       VARCHAR2(10),
    FOREIGN KEY (manager_emp_no) REFERENCES employee(emp_no)
);

CREATE TABLE tour_bus (
    bus_no       VARCHAR2(20) PRIMARY KEY,
    seat_count   NUMBER(3),
    release_year NUMBER(4)
);

CREATE TABLE driver (
    driver_id       VARCHAR2(10) PRIMARY KEY,
    name            VARCHAR2(30) NOT NULL,
    birth_date      DATE NOT NULL,
    phone           VARCHAR2(13) NOT NULL,
    driving_career  NUMBER(3),
    hourly_wage     NUMBER(8) DEFAULT 15000,
    contract_date   DATE,
    contract_period VARCHAR2(20)
);

CREATE TABLE reservation (
    customer_id   VARCHAR2(10),
    tour_no       VARCHAR2(10),
    reserve_date  DATE DEFAULT SYSDATE,
    deposit_paid  CHAR(1) DEFAULT 'N' CHECK (deposit_paid IN ('Y', 'N')),
    tour_fee_paid CHAR(1) DEFAULT 'N' CHECK (tour_fee_paid IN ('Y', 'N')),
    PRIMARY KEY (customer_id, tour_no),
    FOREIGN KEY (customer_id) REFERENCES customer(id),
    FOREIGN KEY (tour_no) REFERENCES tour_product(tour_no)
);

CREATE TABLE driver_assignment (
    tour_no       VARCHAR2(10) PRIMARY KEY,
    driver_id     VARCHAR2(10),
    working_hours NUMBER(5),
    FOREIGN KEY (tour_no) REFERENCES tour_product(tour_no),
    FOREIGN KEY (driver_id) REFERENCES driver(driver_id)
);

CREATE TABLE bus_assignment (
    tour_no VARCHAR2(10) PRIMARY KEY,
    bus_no  VARCHAR2(20),
    FOREIGN KEY (tour_no) REFERENCES tour_product(tour_no),
    FOREIGN KEY (bus_no) REFERENCES tour_bus(bus_no)
);
```

위 내부 스키마에서는 고객의 휴대폰에 `UNIQUE` 제약조건을 지정하였고, 고객 이름과 휴대폰에는 `NOT NULL`을 지정하였다. 고객 등급코드의 기본값은 `'3'`으로 설정하였다. 직원 테이블에서는 생년월일에 `UNIQUE`를 지정하고, 이름, 생년월일, 업무코드, 입사일에는 `NOT NULL`을 지정하였다.

여행상품 테이블에서는 출발지, 도착지, 시작일시, 종료일시, 여행경비가 반드시 입력되도록 하였고, 출발여부의 기본값은 `'N'`으로 설정하였다. 운전기사 테이블에서는 이름, 생년월일, 휴대폰에 `NOT NULL`을 지정하고, 시급의 기본값은 15000으로 설정하였다. 예약 테이블에서는 예약일자의 기본값을 `SYSDATE`로 설정하고, 예약금결제여부와 여행경비결제여부의 기본값을 `'N'`으로 설정하였다.
