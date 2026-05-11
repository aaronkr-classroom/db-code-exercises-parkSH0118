-- User, Game, Item, Play, User_Item

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(30) NOT NULL,
    nickname VARCHAR(30) NOT NULL,
    user_level INT,
    join_date DATE
);

CREATE TABLE game (
    game_id INT PRIMARY KEY,
    game_name VARCHAR(50) NOT NULL,
    genre VARCHAR(20),
    release_date DATE
);

CREATE TABLE item (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(30) NOT NULL,
    item_price INT,
    item_grade CHAR -- 'S'
);

CREATE TABLE play (
    user_id INT,
    game_id INT,
    start_date DATE,
    play_time INT, --시작 : time.now(0, 현재: time.now()
	-- time.now(0 = 176864523 - 176854321 = 102002/202)

    PRIMARY KEY (user_id, game_id),

    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (game_id) REFERENCES game(game_id)
);

CREATE TABLE user_item (
    user_id INT,
    item_id INT,
    acquired_date DATE,
    quantity INT,

    PRIMARY KEY (user_id, item_id),

    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (item_id) REFERENCES item(item_id)
);

TABLE users;
TABLE game;
TABLE item;
TABLE play;
TABLE user_item;

-- INSERT VALUES
-- TABLE USERS
INSERT INTO users VALUES
(1, '김민준', 'DragonK', 15, '2023-01-10'),
(2, '이서연', 'StarY', 22, '2023-02-14'),
(3, '박지훈', 'KnightP', 8, '2023-03-05'),
(4, '최유진', 'MagicC', 31, '2023-04-21'),
(5, '정현우', 'HunterJ', 18, '2023-05-11'),
(6, '한지민', 'LunaH', 27, '2023-06-02'),
(7, '오세훈', 'BladeO', 12, '2023-07-19'),
(8, '강하은', 'AngelG', 25, '2023-08-30');


-- TABLE GAME
INSERT INTO game VALUES
(101, 'Battle Arena', 'Action', '2021-03-15'),
(102, 'Fantasy World', 'RPG', '2020-07-22'),
(103, 'Speed Racing', 'Racing', '2022-01-10'),
(104, 'Puzzle Land', 'Puzzle', '2019-11-05'),
(105, 'Zombie Night', 'Horror', '2023-02-28'),
(106, 'Soccer King', 'Sports', '2021-09-17'),
(107, 'Space War', 'Shooting', '2022-12-01'),
(108, 'Farm Story', 'Simulation', '2020-05-20');


-- TABLE ITEM
INSERT INTO item VALUES
(201, 'Iron Sword', 1500, 'C'),
(202, 'Magic Wand', 3000, 'B'),
(203, 'Dragon Shield', 5000, 'A'),
(204, 'Healing Potion', 500, 'D'),
(205, 'Golden Armor', 7000, 'S'),
(206, 'Speed Boots', 2500, 'B'),
(207, 'Fire Ring', 4500, 'A'),
(208, 'Lucky Charm', 1000, 'C');


-- TABLE PLAY
INSERT INTO play VALUES
(1, 101, '2023-01-15', 120),
(2, 102, '2023-02-20', 300),
(3, 103, '2023-03-10', 80),
(4, 104, '2023-04-25', 150),
(5, 105, '2023-05-15', 220),
(6, 106, '2023-06-08', 180),
(7, 107, '2023-07-22', 95),
(8, 108, '2023-09-01', 260);


-- TABLE USER_ITEM
INSERT INTO user_item VALUES
(1, 201, '2023-01-20', 1),
(2, 202, '2023-02-25', 1),
(3, 204, '2023-03-15', 5),
(4, 203, '2023-04-30', 1),
(5, 205, '2023-05-20', 1),
(6, 206, '2023-06-12', 2),
(7, 207, '2023-07-25', 1),
(8, 208, '2023-09-05', 3);

TABLE users;
TABLE game;
TABLE item;
TABLE play;
TABLE user_item;

- 기본 조회 연습
-- 1. 전체 유저 조회
SELECT * FROM users;

-- 2. 레벨 높은 순서로 조회
SELECT * FROM users
ORDER BY user_level DESC;

-- 3. 레벨이 10 이상인 유저 조회
SELECT * FROM users
WHERE user_level >= 10;

-- 4. 'S' 등급 아이템 조회
SELECT * FROM item
WHERE item_grade = 'S';

-- 테이블 수정할 때 (ALTER TABLE)

-- 1. 게임회사에서 유저의 이메일도 저장하기로 했다.
ALTER TABLE users
ADD email VARCHAR(50);
TABLE users;

-- 2. 유저에게 현재 접속 상태를 저장해야 한다.
ALTER TABLE users
ADD login_status VARCHAR(20);
TABLE users;

-- 3. 아이템 테이블에 판매 가능 여부를 추가해야 한다.
ALTER TABLE item
ADD COLUMN is_sellable BOOLEAN DEFAULT TURE;
TABLE item;

-- 4. 게임 테이블에 게임 등급 정보를 추가해야 한다.
ALTER TABLE game
ADD COLUMN game_rating VARCHAR(10);
TABLE game;

-- 테이블에 있는 값을 변경할 때(UPDATE)

-- 1. 김민준 유저의 이메일을 추가합니다.
UPDATE users
SET email = 'minjun@example.com'
WHERE user_name = '김민준';

-- 2. 이서연 유저의 레벨이 25로 올랐다.
UPDATE users
SET user_level = 25
WHERE user_id = 2;

-- 3. 모든 유저의 기본 접속 상태를 online으로 설정한다.
UPDATE users
SET login_status = 'online';

-- 4. DragonK 유저가 현재 접속 중이다.
UPDATE users
SET login_status = 'online'
WHERE nickname = 'DragonK';

-- 5. 회복포션의 가격을 700으로 변경한다.
UPDATE item
SET item_price = 700
WHERE item_name = 'Healing Potion';

-- 6. Fantasy World의 이용 가능 연령을 12세 이상으로 설정한다.
UPDATE game
SET game_rating = '12세 이상'
WHERE game_id = 102;