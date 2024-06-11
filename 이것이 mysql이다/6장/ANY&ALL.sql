SELECT * FROM usertbl;

-- '김경호'보다 키가 큰 사람을 SELECT하기 위해 SUBQUERY를 활용
SELECT	userName, height
FROM		usertbl
WHERE		height > (SELECT height FROM usertbl WHERE userName = '김경호');

/*
WHERE addr = '경남'의 경우 두개의 값을 반환함.
하위쿼리가 둘 이상의 값을 반환할 경우에는 위와 같이 SUBQUERY가 아닌 ANY를 활용
아래의 값을 통해 170보다 크거나 같은, 그리고 173보다 크거나 같은 값들을 SELECT한다. (결과적으로 170 이상의 값들을 SELECT)
결국 ANY는 서브쿼리의 여러 개 결과 중 한 가지만 만족해도 된다.
*/
SELECT	userName, height 
FROM		usertbl
WHERE		height >= ANY (SELECT height FROM usertbl WHERE addr = '경남');

/*
= ANY는 IN과도 같다.
*/
SELECT	userName, height
FROM		usertbl
WHERE		height IN (SELECT height FROM usertbl WHERE addr = '경남');

/*
ALL의 경우 두 개 이상의 값들 중 모두를 만족시켜야 함.
아래의 경우, 173보다 커야된다.
*/
SELECT	userName, height
FROM		usertbl
WHERE		height >= ALL (SELECT height FROM usertbl WHERE addr = '경남');