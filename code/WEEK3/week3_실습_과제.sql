----- 과정 1번 ------

/*
[Entities / 개체]
Customer

[Properties / 속성]
- customer_id   (BIGSERIAL) -- 자동으로 증가하는 고객 번호 (PK)
- name          (VARCHAR(30)) -- 고객 이름
- email         (VARCHAR(100)) -- 이메일
- phone         (VARCHAR(20)) -- 전화번호
- address       (VARCHAR(200)) -- 주소
- created_at    (DATE) -- 가입일자 ('YYYY-MM-DD')
*/

------ 과정 4번 -------

CREATE TABLE Customer (
    customer_id BIGSERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(200),
    created_at DATE
);

INSERT INTO Customer (name, email, phone, address, created_at)
VALUES
('김민수', 'minsu@test.com', '010-1111-1111', '서울시 강남구', '2026-03-01'),
('이영희', 'younghee@test.com', '010-2222-2222', '부산시 해운대구', '2026-03-02'),
('박지훈', 'jihoon@test.com', '010-3333-3333', '대구시 수성구', '2026-03-03'),
('최수진', 'soojin@test.com', '010-4444-4444', '인천시 연수구', '2026-03-04'),
('정우성', 'woosung@test.com', '010-5555-5555', '광주시 북구', '2026-03-05');

-- 전체 조회
SELECT * FROM Customer;

-- 정렬
SELECT * 
FROM Customer
ORDER BY name ASC;

-- 조건 검색
SELECT * 
FROM Customer
WHERE address = '서울시 강남구';