/**************************************************************************************
기본적인 CREATE, INSERT
CREATE TABLE 테이블명 (칼럼 1, 칼럼 2..);
INSERT INTO 테이블명 (칼럼 1, 칼럼 2, ...) VALUES (로우 1, 로우 2...);
***************************************************************************************/
CREATE TABLE TESTTBL1 (ID INT, USERNAME CHAR(8), AGE INT);

-- 기본적인 INSERT문
INSERT INTO TESTTBL1 VALUES (1, '홍길동', 25);

-- AGE는 NULL로 들어가게 된다.
INSERT INTO TESTTBL1 (ID, USERNAME) VALUES (2, '이즈리얼');

-- 순서를 바꿔서 생성할 수도 있다
INSERT INTO TESTTBL1 (USERNAME, AGE, ID) VALUES ('진', 26, 3);

/**************************************************************************************
CREATE TABLE WITH IDENTITY (= AUTO_INCREMENT)

DBCC CHECKIDENT
***************************************************************************************/
CREATE TABLE TESTTBL2
(
	ID			INT	IDENTITY PRIMARY KEY,
	USERNAME	CHAR(8),
	AGE			INT
);
-- ID는 IDENTITY (자동 숫자 증가)이므로 넣지 않아도 알아서 추가된다.
INSERT INTO TESTTBL2 VALUES ('룰루', 25);
INSERT INTO TESTTBL2 VALUES ('스웨인', 21);
INSERT INTO TESTTBL2 VALUES ('가렌', 21);

SELECT * FROM TESTTBL2;

/*
ALTER TABLE TESTTBL2 AUTO_INCREMENT = 100; 과 같은 결과를 가져온다.

ID 정보 확인: 현재 ID 값은 '3'입니다.
DBCC 실행이 완료되었습니다. DBCC에서 오류 메시지를 출력하면 시스템 관리자에게 문의하십시오.

완료 시간: 2024-06-15T16:17:27.7681552+09:00
*/
DBCC CHECKIDENT ('TESTTBL2', RESEED, 100);

INSERT INTO TESTTBL2 VALUES ('스몰더', 2);	-- ID = 101
INSERT INTO TESTTBL2 VALUES ('베인', 50);	-- ID = 102

SELECT * FROM TESTTBL2;

CREATE TABLE TESTTBL3
(
ID			INT	IDENTITY(1, 2)	PRIMARY KEY,	-- 2씩 증가하도록 설정
USERNAME	CHAR(8),
AGE			INT
);

INSERT INTO TESTTBL3 (USERNAME, AGE) VALUES ('베인', 50);	-- ID = 1
INSERT INTO TESTTBL3 VALUES ('스몰더', 2);					-- ID = 3

SELECT * FROM TESTTBL3;

/**************************************************************************************
샘플 데이터 생성
이를 통해 대량의 데이터들을 다른 테이블에 넣어줄 수 있다.
INSERT INTO 테이블명 (칼럼1, 칼럼 2..) SELECT문;
***************************************************************************************/
CREATE TABLE TESTTBL4
(
	ID				INT,
	USERNAME		CHAR(8),
	AGE				INT
);

INSERT INTO TESTTBL4 
	SELECT ID, USERNAME, AGE FROM TESTTBL1;

SELECT * FROM TESTTBL4;
/**************************************************************************************
UPDATE, DELETE
UPDATE 테이블명 SET 컬럼1 = '변경할 값' WHERE 조건
DELETE FROM 테이블명 WHERE 조건
***************************************************************************************/
UPDATE TESTTBL4
SET USERNAME = '룰루', AGE = 25
WHERE ID = 1;

SELECT A.ID, A.USERNAME, A.AGE FROM TESTTBL2 A
	INNER JOIN TESTTBL4 B ON A.ID = B.ID AND A.USERNAME = B.USERNAME AND A.AGE = B.AGE

-- UPDATE를 하되, INNER JOIN을 통해 같은 값이 도출된 것들을 변경함
-- 즉, WHERE대신 JOIN을 통해 조건을 준 것이라 생각하면 된다. (★★★)
UPDATE TESTTBL4
SET USERNAME = 'TEST', AGE = '1'
FROM TESTTBL4 A
	INNER JOIN TESTTBL2 B ON A.ID = B.ID AND A.USERNAME = B.USERNAME AND A.AGE = B.AGE

SELECT * FROM TESTTBL4

DELETE FROM TESTTBL4 WHERE USERNAME = 'TEST'

/**************************************************************************************
***************************************************************************************/
CREATE TABLE TESTTBL5
(
	ID			INT PRIMARY KEY,
	USERNAME	CHAR(8),
	AGE			INT
);

INSERT INTO TESTTBL5 SELECT ID, USERNAME, AGE FROM TESTTBL2	-- TOP 3로 3건만 가져옴
ALTER TABLE TESTTBL5 ADD CONSTRAINT PK_TESTTBL5 PRIMARY KEY (ID);
