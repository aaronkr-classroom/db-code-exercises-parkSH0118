# chp3 실습 과제

## Step 1. 시스템 선택
동아리 관리 시스템
이 시스템은 학생이 동아리 정보를 조회하고 가입 신청을 할 수 있으며, 관리자가 동아리 정보와 가입 신청 내역을 관리할 수 있도록 구성한다.

## Step 2. 요구사항 작성
### 1) 사용자
1. 학생
2. 동아리 관리자

### 2) 요구사항
1. 학생은 동아리 목록을 조회할 수 있어야 한다.
2. 학생은 특정 동아리의 이름, 분야, 설명, 모집 상태를 확인할 수 있어야 한다.
3. 학생은 원하는 동아리에 가입 신청을 할 수 있어야 한다.
4. 학생은 자신이 신청한 가입 내역을 확인할 수 있어야 한다.
5. 동아리 관리자는 동아리 정보를 등록할 수 있어야 한다.
6. 동아리 관리자는 동아리 정보를 수정할 수 있어야 한다.
7. 동아리 관리자는 가입 신청 내역을 조회할 수 있어야 한다.
8. 동아리 관리자는 가입 신청을 승인 또는 거절할 수 있어야 한다.
9. 동아리 관리자는 동아리별 신청 학생 목록을 조회할 수 있어야 한다.

## Step 3. 데이터 설계
### 1) 엔티티
1. 회원
2. 동아리
3. 가입신청

### 2) 엔티티별 속성
#### [회원]
- 회원번호 (member_id) : 회원 식별 번호
- 이름 (name) : 회원 이름
- 학번 (student_no) : 학생 학번
- 학과 (department) : 소속 학과
- 전화번호 (phone) : 연락처
- 이메일 (email) : 이메일 주소

#### [동아리]
- 동아리번호 (club_id) : 동아리 식별 번호
- 동아리명 (club_name) : 동아리 이름
- 분야 (category) : 동아리 분야
- 설명 (description) : 동아리 소개
- 모집상태 (recruit_status) : 모집 중 여부

#### [가입신청]
- 신청번호 (application_id) : 신청 식별 번호
- 회원번호 (member_id) : 신청한 학생 번호
- 동아리번호 (club_id) : 신청 대상 동아리 번호
- 신청일 (apply_date) : 가입 신청 날짜
- 신청상태 (status) : 대기, 승인, 거절 상태

### 3) 엔티티 간 관계
1. 한 명의 회원은 여러 개의 가입신청을 할 수 있다.
2. 하나의 동아리에는 여러 개의 가입신청이 들어올 수 있다.
3. 가입신청은 회원과 동아리를 연결하는 역할을 한다.

따라서 회원과 동아리는 직접 연결하기보다, 가입신청 엔티티를 통해 관계를 표현하도록 설계하였다.

## Step 4. SQL 작성
/* =====================================================
   1. 테이블 생성
   ===================================================== */

CREATE TABLE member (
    member_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    student_no VARCHAR(20) NOT NULL UNIQUE,
    department VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE club (
    club_id INT PRIMARY KEY,
    club_name VARCHAR(50) NOT NULL,
    category VARCHAR(30),
    description VARCHAR(200),
    recruit_status VARCHAR(20) NOT NULL
);

CREATE TABLE application (
    application_id INT PRIMARY KEY,
    member_id INT NOT NULL,
    club_id INT NOT NULL,
    apply_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (member_id) REFERENCES member(member_id),
    FOREIGN KEY (club_id) REFERENCES club(club_id)
);

/* =====================================================
   2. 데이터 삽입
   ===================================================== */

INSERT INTO member (member_id, name, student_no, department, phone, email) VALUES
(1, '김민수', '2024001', '컴퓨터공학과', '010-1111-1111', 'minsu@ut.ac.kr'),
(2, '이서연', '2024002', '경영학과', '010-2222-2222', 'seoyeon@ut.ac.kr'),
(3, '박지훈', '2024003', '기계공학과', '010-3333-3333', 'jihoon@ut.ac.kr');

INSERT INTO club (club_id, club_name, category, description, recruit_status) VALUES
(1, '코딩 동아리', '학술', '프로그래밍 학습 및 프로젝트 진행', '모집중'),
(2, '축구 동아리', '체육', '축구 연습 및 교류전 진행', '모집중'),
(3, '사진 동아리', '예술', '사진 촬영과 전시 활동', '모집마감');

INSERT INTO application (application_id, member_id, club_id, apply_date, status) VALUES
(1, 1, 1, '2026-03-20', '대기'),
(2, 2, 2, '2026-03-21', '승인'),
(3, 3, 1, '2026-03-22', '거절'),
(4, 1, 2, '2026-03-23', '대기');

/* =====================================================
   3. 전체 조회
   ===================================================== */

SELECT * FROM member;
SELECT * FROM club;
SELECT * FROM application;

/* =====================================================
   4. 특정 컬럼 조회
   ===================================================== */

SELECT name, department FROM member;
SELECT club_name, category, recruit_status FROM club;

/* =====================================================
   5. 조건 조회
   ===================================================== */

SELECT *
FROM club
WHERE recruit_status = '모집중';

SELECT *
FROM application
WHERE status = '대기';

/* =====================================================
   6. 정렬 조회
   ===================================================== */

SELECT *
FROM member
ORDER BY name ASC;

SELECT *
FROM application
ORDER BY apply_date DESC;