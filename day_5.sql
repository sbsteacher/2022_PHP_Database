 -- 형변환 convert
 SELECT '10';
 SELECT CONVERT('10', INT);
 
 SELECT '22a1a' + '33b2b';
 SELECT '10' + '10';
 SELECT CONVERT('10', INT) + CONVERT('10', INT);
 
 SELECT CONVERT('10.1', FLOAT);
 SELECT CONVERT(10.1, FLOAT);
 
 SELECT 10; 
 SELECT CONVERT(10, CHAR);
 
 -- 형변환 case
 SELECT CAST('10' AS INT);
 
 SELECT 1 >= '1a2ega';
 
 
 -- 문자열 합치기 concat
SELECT 'A1' + '2B2';
SELECT CONCAT('A1', '2B2', 12);
SELECT CONCAT('A1', '2B2', '가나다');
 
 
-- IF
-- 식 ? true일 때 : false 일 때 
SELECT if(100>200, '100은 200보다 크다', '100은 200보다 작다');
USE `employees`;

-- employees 테이블을 조회하는데 gender 값이 'M'이면 '남자', 'F'이면 '여자'가 뜨도록 해주세요.
SELECT gender, IF(gender = 'M', '남자', '여자'), IF(gender = 'F', '여자', '남자')
FROM employees;
 
-- 응용
SELECT 'M', 'F', 'A';

SELECT IF('A' = 'M', '남자', IF('A' = 'F', '여자', '외계인') );

SELECT 'M';
SELECT 'F';
SELECT 'A';
-- 응용 2 (농구, 배구, 축구)
-- 농구 > basketball
-- 배구 > valleyball
-- 축구 > football

SELECT nm, IF(nm = '농구', 'basketball',   IF(nm = '배구', 'valleyball', 'football')  ) 'eng'
FROM t_hobbit;
 
-- 익명 제보 
SELECT 
if(nm = '농구',  
	CONCAT(nm, 'basketball'), 
	if(nm = '배구', 
		CONCAT(nm, 'valleyball'), 
		CONCAT(nm, 'football')
	)
)  
FROM t_hobbit;

SELECT 
	CONCAT(nm, 
		IF(nm = '농구', 'basketball', IF(nm = '배구', 'valleyball', 'football')  )
	)
FROM t_hobbit;

-- ifnull (오라클 : nvl, SQL-Server : isnull)
SELECT *, IFNULL(memberaddress, '주소없음')
FROM membertbl;

-- nullif
SELECT NULLIF('안녕', '안녕');
SELECT NULLIF('안녕1', '안녕2');

-- case 값 when 비교값 then ...
-- 농구 > basketball
-- 배구 > valleyball
-- 축구 > football
SELECT 
	nm,
	CASE nm WHEN '농구' THEN 'basketball'
	   	  WHEN '배구' THEN 'valleyball'
	   	  WHEN '축구' THEN 'football'
	   	  ELSE '없음'
	END
FROM t_hobbit;

-- case when 조건식 then ...
SELECT
	nm,
	CASE WHEN nm = '농구' THEN 'basketball'
	     WHEN nm = '배구' THEN 'valleyball'
	     WHEN nm = '축구' THEN 'football'
	     ELSE '없음'
	END
FROM t_hobbit;


-- 아스키코드
SELECT ASCII('나'), CONVERT(CHAR(65), CHAR), CHAR(65);

-- 문자열 합치기 concat, concat_ws 
SELECT CONCAT('A', '_', 'B', '_', 'C');
SELECT CONCAT_WS(',', 'A', 'B', 'C');

-- format 천다위 콤마, 실수 몇자리까지 나타낼지 선택 
SELECT FORMAT(11112222.123456, 0);

SELECT FORMAT(FLOOR(11112222.623456), 0);

SELECT FLOOR(11.5), CEIL(11.5), ROUND(11.5);
SELECT FLOOR(11.1), CEIL(11.01), ROUND(11.1);

-- format(1/3, 10)는 0.33333300으로 나오는데 이유는?
-- double, float은 근사치 값을 저장하기 때문.
SELECT FORMAT(CONVERT(1/3, FLOAT), 12), format(convert(1/3, DOUBLE), 12);



-- INSERT 
SELECT 
	INSERT('abcdefghi', 3, 4, '@@@@!!!!')
 , INSERT('abcdefghi', 3, 0, '@@@@');


-- upper, lower
SELECT 
 'aBc'
, 'AbC'
, 'aBc' = 'AbC'
, UPPER('aBc')
, UPPER('AbC')
, UPPER('aBc') = UPPER('AbC');

SELECT '   a  bc    ', LTRIM('   a  bc    '),  TRIM('   a  bc    ');
SELECT TRIM(BOTH ' ' FROM '     a bc   ');

-- date_format
SELECT *, DATE_FORMAT(created_at, '%Y/%m/%d %p %h:%i') FROM t_hobbit_2;




 