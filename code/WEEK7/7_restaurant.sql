-- Customer Table
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(13),
    address VARCHAR(100)
);

-- Restaurant Table
CREATE TABLE Restaurant (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(13),
    address VARCHAR(100)
);

-- Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    restaurant_id INT,
    order_date TIMESTAMP,
    total NUMERIC,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurant(restaurant_id)
);

-- Delivery Table
CREATE TABLE Delivery (
    delivery_id INT PRIMARY KEY,
    order_id INT,
    driver_name VARCHAR(100),
    status INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Data 삽입
INSERT INTO Customer VALUES
(1, '김민수', '010-1234-5678', '서울시 강남구'),
(2, '이수진', '010-2345-6789', '서울시 서초구');

INSERT INTO Restaurant VALUES
(1, '맛있는치킨', '02-111-2222', '서울시 강남구 테헤란로'),
(2, '행복피자', '02-333-4444', '서울시 서초구 반포대로');

INSERT INTO Orders VALUES
(1, 1, 1, '2026-04-13 18:30:00', 22000),
(2, 2, 2, '2026-04-13 19:00:00', 28000);

INSERT INTO Delivery VALUES
(1, 1, '박기사', 1), --0: 받았다, 1: 조리하다, 2: 배달중, 3: 배달완료, 4: 취소
(2, 2, '최기사', 3);

-- DB 퀴리
SELECT * FROM Orders;
SELECT * FROM Orders ORDER BY total ASC;
SELECT * FROM Orders WHERE total >= 10000;
SELECT * FROM Delivery WHERE status 3 = 3;