-- dept_emp 테이블에서 dept_no 종류가 몇개가 있는지?
SELECT DISTINCT dept_no FROM dept_emp;

-- 사원의 직무가 무엇이 있는지 select 해주시오.
SELECT DISTINCT title 
FROM titles
ORDER BY title;

-- limit ?    /////  limit ?, ?
SELECT * FROM employees
LIMIT 30;

SELECT * FROM employees
LIMIT 20, 10;

/* 가장 많은 연봉을 받은 금액 3개만 나오도록 해주세요. (사람, 연도 상관 없음)  */
SELECT * FROM salaries
ORDER BY salary DESC
LIMIT 3;

/* 위의 결과에서 5~10위만 나오도록  */
SELECT * FROM salaries
ORDER BY salary DESC
LIMIT 4, 6;

/* 테이블 복사 */

-- 테이블 컬럼, 데이터타입, 레코드 복사.
CREATE TABLE departments_temp2 AS
SELECT * FROM departments;

-- 테이블 스키마 복사 (레코드 X)
CREATE TABLE departments_temp3 
LIKE departments;

INSERT INTO departments_temp3
SELECT * FROM departments;

-- 그룹 함수 min, max, sum, avg, count

-- group by 를 사용 안 했을 때는 전체에서 값을 가져온다.
SELECT MIN(salary), MAX(salary), SUM(salary), AVG(salary), COUNT(emp_no) 
, SUM(salary) / COUNT(*)
FROM salaries;


SELECT emp_no, MIN(salary), MAX(salary), SUM(salary), AVG(salary), COUNT(*)
FROM salaries
GROUP BY emp_no;

/* 부서별 사원 수, 부서별 사원수가 20,000명 이상인 부서만 나오도록 한다.  */
SELECT dept_no, COUNT(*) 
  FROM dept_emp
 GROUP BY dept_no
 HAVING COUNT(*) >= 20000
 ORDER BY COUNT(*) desc;
 
 
 SELECT dept_no, COUNT(*) 
  FROM dept_emp
 GROUP BY dept_no;
  
/* 가장 적은 salary를 받은 사람의 이름이 나오도록 해주세요. */
SELECT * FROM employees
WHERE emp_no = (
	SELECT emp_no
	FROM salaries
	GROUP BY emp_no
	ORDER BY MIN(salary)
	LIMIT 1
);

SELECT * FROM employees
WHERE emp_no = (
	SELECT emp_no FROM salaries
	WHERE salary = (SELECT min(salary) FROM salaries)
);


SELECT * FROM employees
WHERE emp_no = 253406;

SELECT emp_no FROM salaries WHERE salary = 38623; -- 253406

SELECT min(salary) FROM salaries; -- 38623

SELECT * FROM employees
WHERE emp_no = (
	SELECT emp_no FROM salaries
	ORDER BY salary
	LIMIT 1
);

SELECT * FROM employees
WHERE emp_no = (SELECT emp_no FROM salaries ORDER BY salary LIMIT 1);

SELECT * FROM employees
WHERE emp_no in
(
	SELECT emp_no FROM salaries
	WHERE salary = (SELECT MIN(salary) FROM salaries)
);

-- auto_increment
USE `test`;

CREATE TABLE t_hobbit(
	i_hobbit INT UNSIGNED AUTO_INCREMENT,
	nm VARCHAR(10) UNIQUE NOT NULL,
	PRIMARY KEY (i_hobbit)
);

INSERT INTO t_hobbit (nm)
VALUES ('농구');

INSERT INTO t_hobbit (nm)
VALUES ('축구');

INSERT INTO t_hobbit (nm)
VALUES ('배구');

SELECT * FROM t_hobbit;



CREATE TABLE t_hobbit_2 (
	hobbit_id INT UNSIGNED PRIMARY KEY,
	NAME VARCHAR(20) NOT NULL,
	created_at DATETIME DEFAULT NOW()
);
INSERT INTO t_hobbit_2
(hobbit_id, NAME)
VALUES
(1, '핸드볼');


INSERT INTO t_hobbit_2
(hobbit_id, NAME, created_at)
VALUES
(2, '등산', '2022-02-10');

INSERT INTO t_hobbit_2
(hobbit_id, NAME, created_at)
VALUES
(3, '독서', '2022-02-12 12:12:13');

SELECT * FROM t_hobbit;
SELECT * FROM t_hobbit_2;

INSERT INTO t_hobbit_2
(hobbit_id, NAME)
SELECT i_hobbit + 3, nm FROM t_hobbit;

-- 각 직업별로 평균 급여를 보고 싶으면 어떻게 하면 될까요?
-- (아직 join을 배우지 않은 상태)
USE `employees`;

SELECT title, AVG(salary) AS avg_salary
  FROM titles A
 INNER JOIN salaries B
    ON A.emp_no = B.emp_no
 GROUP BY A.title;

-- emp_no: 10001의 모든 salary를 1,000씩 올리고 싶다.
UPDATE salaries
SET salary = salary + 1000
WHERE emp_no = 10001;


SELECT * FROM salaries
WHERE emp_no = 10001;



-- insert ignore
SELECT * FROM t_hobbit_2;
INSERT IGNORE INTO t_hobbit_2 ( hobbit_id, NAME ) VALUES (7, '탁구');
INSERT IGNORE INTO t_hobbit_2 ( hobbit_id, NAME ) VALUES (8, '스키');


INSERT INTO t_hobbit_2 ( hobbit_id, NAME ) VALUES (8, '산책')
ON DUPLICATE KEY UPDATE NAME = '달리기';

DROP TABLE t_board;
CREATE table t_board(
	i_board INT UNSIGNED PRIMARY KEY,
	title VARCHAR(20) UNIQUE NOT NULL,
	hits INT UNSIGNED DEFAULT 0
);

SELECT * FROM t_board;

INSERT INTO t_board (i_board, title, hits) VALUES (2, '안녕', 0)
ON DUPLICATE KEY UPDATE hits = hits + 1;

WITH dept_emp_d001(aaa, from_date, to_date)
AS (
	SELECT emp_no, from_date, to_date 
	FROM dept_emp
	WHERE dept_no = 'd001'
)
SELECT A.* FROM dept_emp_d001 AS A;


SELECT * FROM 
(
	SELECT emp_no, from_date, to_date 
	FROM dept_emp
	WHERE dept_no = 'd001'
) A;


/* 사람별 평균 급여에의 평균값보다 큰 사람들의 이름이 나오게 해주세요.  */
SELECT * FROM employees 
WHERE emp_no IN (
	SELECT emp_no
	FROM salaries
	GROUP BY emp_no
	HAVING AVG(salary) >= (
		SELECT avg(avg_salary) FROM (
			SELECT 1 as val, AVG(salary) AS avg_salary FROM salaries
			GROUP BY emp_no
		) A
		GROUP BY val
	)
);

SELECT * FROM t_order; 
DROP TABLE t_order;
CREATE TABLE t_order(
 o_no INT UNSIGNED PRIMARY KEY,
 cus_no INT UNSIGNED,
 o_date DATE DEFAULT current_time,
 o_price INT DEFAULT 0,
 FOREIGN KEY (cus_no) REFERENCES t_customer(cus_no)
);

SELECT * FROM t_customer;
DROP TABLE t_customer;
CREATE TABLE t_customer(
 cus_no INT UNSIGNED,
 nm VARCHAR(10) NOT NULL,
 PRIMARY KEY (cus_no)
);


INSERT INTO t_customer
(cus_no, nm)
VALUES 
(3, '홍길동'),
(5, '이순신');

SELECT * FROM t_customer;

INSERT INTO t_order
(o_no, cus_no, o_price)
VALUES
(1, 3, 55000),
(2, 5, 70000),
(3, 3, 60000);

SELECT * FROM t_order;

UPDATE t_customer
SET nm = '장보고'
WHERE cus_no = 5;

DELETE FROM t_order
WHERE o_no = 2;

SELECT o_no, o_price 
FROM t_order
WHERE cus_no = 3;

INSERT INTO t_order
(o_no, cus_no, o_price)
VALUES
(4, 4, 55000);














