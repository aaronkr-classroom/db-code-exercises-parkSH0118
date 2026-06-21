# 12장 연습문제 답안

## 개념퍼즐

### 가로

1. 문제: 가장 최근에 생성된 현재 시퀀스 값을 반환하는 의사열  
   답: `CURRVAL`

2. 문제: 시퀀스를 변경하는 명령  
   답: `ALTER SEQUENCE`

3. 문제: 시퀀스를 삭제하는 명령  
   답: `DROP SEQUENCE`

4. 문제: 사용자가 수동으로 인덱스를 생성하는 명령  
   답: `CREATE INDEX`

10. 문제: 테이블 구조는 남겨두고 저장된 데이터만 삭제하는 명령  
    답: `TRUNCATE TABLE`

12. 문제: 기본 테이블의 구조를 변경하는 명령  
    답: `ALTER TABLE`

13. 문제: 기본 테이블로부터 만들어지는 가상 테이블인 뷰를 생성하는 명령  
    답: `CREATE VIEW`

14. 문제: 기본 테이블 구조와 함께 저장된 데이터와 인덱스까지 한꺼번에 삭제하는 명령  
    답: `DROP TABLE`

15. 문제: DDL 문으로 만들어지지 않고, 질의문 처리 과정의 중간 결과로 만들어지는 테이블  
    답: 임시 테이블

16. 문제: 기존 테이블에 새로운 데이터를 삽입하는 명령  
    답: `INSERT`

19. 문제: 시퀀스에 의해 자동으로 생성되는 가상의 열  
    답: 의사열

20. 문제: `CREATE VIEW` 명령을 이용해서 기본 테이블로부터 만들어지는 테이블  
    답: 가상 테이블

22. 문제: 단 하나의 테이블만 기초로 하여 생성된 뷰  
    답: 단순 뷰

23. 문제: 테이블에서 기존 데이터를 갱신하는 명령  
    답: `UPDATE`

### 세로

1. 문제: 시퀀스를 생성하는 명령  
   답: `CREATE SEQUENCE`

5. 문제: 기존 뷰를 삭제하는 명령  
   답: `DROP VIEW`

6. 문제: 기존 테이블에 새로운 데이터를 삽입하는 명령  
   답: `INSERT`

7. 문제: 테이블에서 기존 데이터를 삭제하는 명령  
   답: `DELETE`

8. 문제: 기본 테이블을 생성하는 명령  
   답: `CREATE TABLE`

9. 문제: 다음에 사용 가능한 시퀀스 값을 생성하는 의사열  
   답: `NEXTVAL`

11. 문제: 고정길이 문자열을 기억하는 데이터 타입  
    답: `CHAR`

17. 문제: 테이블에서 데이터를 검색하는 명령  
    답: `SELECT`

18. 문제: 독자적으로 존재하는 테이블  
    답: 기본 테이블

21. 문제: 다중 테이블을 기초로 하여 생성된 뷰  
    답: 복합 뷰

---

## 연습문제

### 1. 문제

DB 구현 단계의 주요 업무가 아닌 것은?

### 답

② 생성된 DB 구조가 설계된 DB 구조와 정확히 일치하는지 확인한다.

---

### 2. 문제

내부 스키마를 기초로 하여 `lab` 테이블을 생성하는 SQL 문을 작성하시오.

### 답

```sql
CREATE TABLE lab (
    lab_num  NUMERIC(3),
    name     VARCHAR(50) NOT NULL,
    building VARCHAR(50) NOT NULL,
    room_id  CHAR(4),
    dept_id  CHAR(4),

    CONSTRAINT lab_pk PRIMARY KEY (lab_num),
    CONSTRAINT lab_name_uk UNIQUE (name),
    CONSTRAINT lab_dept_fk FOREIGN KEY (dept_id)
        REFERENCES dept(id)
);
```

---

### 3. 문제

`lab` 테이블에 숫자 타입 4바이트의 `lab_size` 열을 추가하고, 디폴트 값을 50으로 설정하는 SQL 문을 작성하시오.

### 답

```sql
ALTER TABLE lab
ADD COLUMN lab_size INTEGER DEFAULT 50;
```

---

### 4. 문제

`lab` 테이블의 `room_id` 열에 `room_id_idx`라는 인덱스를 생성하는 SQL 문을 작성하시오.

### 답

```sql
CREATE INDEX room_id_idx
ON lab(room_id);
```

---

### 5. 문제

`lab` 테이블에 다음 데이터를 삽입하는 SQL 문을 작성하시오.

- 실험실번호: 188, 명칭: 가상현실, 건물명: 2공학관, 호실: B283, 소속학과: comp
- 실험실번호: 118, 명칭: 인공지능, 건물명: 2공학관, 호실: A181, 소속학과: comp

### 답

```sql
INSERT INTO lab (lab_num, name, building, room_id, dept_id)
VALUES (188, '가상현실', '2공학관', 'B283', 'comp');

INSERT INTO lab (lab_num, name, building, room_id, dept_id)
VALUES (118, '인공지능', '2공학관', 'A181', 'comp');
```

---

### 6. 문제

건물명이 `2공학관`인 모든 실험실의 명칭과 소속학과번호를 검색하는 SQL 문을 작성하시오.

### 답

```sql
SELECT name, dept_id
FROM lab
WHERE building = '2공학관';
```

---

### 7. 문제

명칭이 `인공지능`인 실험실의 호실을 `B102`로 변경하는 SQL 문을 작성하시오.

### 답

```sql
UPDATE lab
SET room_id = 'B102'
WHERE name = '인공지능';
```

---

### 8. 문제

`lab` 테이블을 기초로 하여 소속학과 id가 `comp`인 모든 실험실의 명칭, 호실, 면적을 포함하는 `com_lab_view`라는 뷰를 생성하는 SQL 문을 작성하시오.

### 답

```sql
CREATE VIEW com_lab_view AS
SELECT name, room_id, lab_size
FROM lab
WHERE dept_id = 'comp';
```

---

### 9. 문제

`lab` 테이블의 기본키인 실험실번호 값을 자동으로 생성하는 데 사용할 시퀀스 `lab_num_seq`를 생성하는 SQL 문을 작성하시오.

첫 번째 시퀀스 값은 120이고, 최대 990까지 10씩 증가시키며, 최댓값에 도달한 후 다시 첫 번째 시퀀스 번호부터 생성하지 않고, 시퀀스 값을 미리 생성하지 않도록 정의한다.

### 답

```sql
CREATE SEQUENCE lab_num_seq
START WITH 120
INCREMENT BY 10
MAXVALUE 990
NO CYCLE
CACHE 1;
```

---

### 10. 문제

`lab_num_seq`를 이용해서 `lab` 테이블에 다음 데이터를 삽입하는 SQL 문을 작성하시오.

- 명칭: 네트워크, 건물명: 2공학관, 호실: B281, 소속학과: comp

### 답

```sql
INSERT INTO lab (lab_num, name, building, room_id, dept_id)
VALUES (nextval('lab_num_seq'), '네트워크', '2공학관', 'B281', 'comp');
```

---

### 11. 문제

앞에서 생성한 테이블과 인덱스, 뷰, 시퀀스를 모두 삭제하는 SQL 문을 작성하시오.

### 답

```sql
DROP VIEW com_lab_view;

DROP INDEX room_id_idx;

DROP TABLE lab;

DROP SEQUENCE lab_num_seq;
```
