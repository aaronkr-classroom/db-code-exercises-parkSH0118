/*
-- 문화센터 예시

-- 릴레이션 스키마
    강사(강사번호(PK), 이름, 전문분야, 연락처)
    강좌(강좌번호(PK), 강좌명, 수강료, 최대인원, 강사번호(FK))
    회원(회원번호(PK), 이름, 전화번호, 가입일)
    수강신청(회원번호(FK), 강좌번호(FK), 신청일)

-- 간단한 ERD
    강사 -- 1:N -- 강좌 -- N:M -- 회원
    강사 -- 1:N -- 강좌 -- 1:M -- 수강신청 -- N:1 -- 회원
*/

CREATE TABLE instructors (
    instructor_id INT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    specialty VARCHAR(50),
    phone VARCHAR(13)
);

CREATE TABLE classes (
    -- 최대인원은 5~50명 CHECK 필수
    class_id INT PRIMARY KEY,
    class_name VARCHAR(50) NOT NULL,
    fee INT CHECK (fee >= 0),
    max_students INT CHECK (max_students BETWEEN 5 AND 50),
    instructor_id INT,

    FOREIGN KEY (instructor_id)
        REFERENCES instructors(instructor_id)
);

CREATE TABLE members (
    member_id INT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    phone VARCHAR(13),
    join_date DATE
);

CREATE TABLE registrations (
    member_id INT,
    class_id INT,
    register_date DATE,

    PRIMARY KEY (member_id, class_id),

    FOREIGN KEY (member_id)
        REFERENCES members(member_id)
        ON DELETE CASCADE,

    FOREIGN KEY (class_id)
        REFERENCES classes(class_id)
        ON DELETE CASCADE
);

-- INSERT INTO instructors
INSERT INTO instructors VALUES
(1, '김영희', '요가', '010-1111-1111'),
(2, '박민수', '기타', '010-2222-2222'),
(3, '이수진', '도예', '010-3333-3333');

-- INSERT INTO classes
INSERT INTO classes VALUES
(101, '힐링 요가', 50000, 20, 1),
(102, '통기타 기초', 70000, 15, 2),
(103, '생활 도예', 80000, 25, 3);

-- INSERT INTO members
INSERT INTO members VALUES
(1001, '최지훈', '010-4444-4444', '2024-03-01'),
(1002, '정다은', '010-5555-5555', '2024-03-05'),
(1003, '한서준', '010-6666-6666', '2024-03-10'),
(1004, '오민지', '010-7777-7777', '2024-03-15'),
(1005, '강현우', '010-8888-8888', '2024-03-20');

-- INSERT INTO registrations
INSERT INTO registrations VALUES
(1001, 101, '2024-04-01'),
(1001, 102, '2024-04-02'),
(1002, 101, '2024-04-01'),
(1003, 103, '2024-04-03'),
(1004, 102, '2024-04-04'),
(1005, 103, '2024-04-05');

-- JOIN
SELECT m.name, c.class_name
FROM registrations r
JOIN members m ON r.member_id = m.member_id
JOIN classes c ON r.class_id = c.class_id;

-- INDEX
-- members2에서 10,000명 추가
CREATE TABLE members2 (
    member_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    phone VARCHAR(13),
    join_date DATE
);

INSERT INTO members2(name, phone, join_date)
SELECT
    'member_' || g,
    '010-' || LPAD((random() * 9999)::int::text, 4, '0')
           || '-'
           || LPAD((random() * 9999)::int::text, 4, '0'),
    CURRENT_DATE - ((random() * 1000)::int)
FROM generate_series(1, 10000) g;

INSERT INTO members2(name, phone, join_date)
VALUES ('홍길동', '010-1234-5678', CURRENT_DATE);

TABLE members2;

-- 검색 시간 확인하기, INDEX 없이
EXPLAIN ANALYZE
SELECT *
FROM members2
WHERE name = '홍길동';

-- INDEX 추가
CREATE INDEX idx_members2_name
ON members2(name);

-- 검색 시간 확인하기, INDEX 사용
EXPLAIN ANALYZE
SELECT *
FROM members2
WHERE name = '홍길동';

-- VIEW 추가
CREATE VIEW registration_view AS
SELECT
    m.name AS 회원명,
    c.class_name AS 강좌명,
    r.register_date AS 신청일
FROM registrations r
JOIN members m ON r.member_id = m.member_id
JOIN classes c ON r.class_id = c.class_id;

SELECT *
FROM registration_view;