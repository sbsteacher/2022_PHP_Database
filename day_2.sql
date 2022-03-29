USE employees;

SELECT * FROM departments;
/* 
1.departments테이블에 레코드를 등록해 주세요.
dept_no : d010
dept_name : Business
*/
INSERT INTO departments
(dept_name, dept_no)
VALUES
('Business', 'd011');


SELECT * FROM employees
WHERE emp_no = 500000;
/*
2. employees 테이블에 근로자 등록
emp_no: 500000
birth_date : 1999-10-10
first_name : Gildong
last_name : Hong
gender : M
hire_date : 2022-03-29
*/
INSERT INTO employees
(emp_no, birth_date, first_name, last_name, gender, hire_date)
VALUES
(500000, '1999-10-10', 'Gildong', 'Hong', 'M', '2022-03-29');

DELETE FROM employees
WHERE emp_no = 500000;

/*
employees 테이블에서 여자면서 last_name에  'ch'가 포함되어 있는 사람들 모두 
select하시오.
*/
SELECT * FROM employees
WHERE gender = 'F'
AND last_name LIKE '%ch%';


/* 함수 사용 (left, right, mid), like 기능 언더바(자리차지)  */
SELECT * FROM employees
WHERE LEFT(birth_date, 4) >= '1960'; 

SELECT * FROM employees
WHERE birth_date LIKE '____-0_-__';

SELECT birth_date, RIGHT(birth_date, 2), MID(birth_date, 6, 2)
FROM employees;


SELECT * FROM employees WHERE emp_no = 500000;
/* 
employees 테이블에서
emp_no: 500000 사원의 성별을 여성으로 바꾸고, 
hire_date는 2021-03-29로 바꾸고, 
first_name은 Jindong으로 변경
*/ 
UPDATE employees
SET gender = 'F'
, hire_date = '2021-03-29'
, first_name = 'Jindong'
WHERE emp_no = 500000;

/* employees 테이블에서 고용일자가 2020년 이후인 사람들 삭제하는 쿼리문   */
DELETE FROM employees
WHERE LEFT(hire_date, 4) >= '2020';


SELECT 1+1 AS ddd;


SELECT emp_no 'gender' FROM employees;
WHERE LEFT(hire_date, 4) >= '2020';


DESC employees;

/* emp_no = 499613인 근로자의 생년월일과 같은 사람을 찾자.  */ 

SELECT * FROM employees
WHERE birth_date = '1953-06-09';

SELECT birth_date FROM employees
WHERE emp_no = 499613;

SELECT * FROM employees
WHERE birth_date = (SELECT birth_date FROM employees WHERE emp_no = 499613);


/*
emp_no : 499619
사람과 같은 성별을 갖고 있는 사람만 나타나도록 해주세요. 
(그리고 499619인 사람은 select 결과물에 안 나오도록 해주세요.)
*/
SELECT * FROM employees
WHERE gender = (SELECT gender FROM employees WHERE emp_no = 499619);


SELECT * FROM employees
WHERE gender = (SELECT gender FROM employees WHERE emp_no = 499619);


SELECT gender FROM employees
WHERE emp_no = 499619;

/* = 과 서브쿼리를 사용할 떄는 서브쿼리가 스칼라값이어야 한다. */
-- some과 any는 동일하다.
-- 786,848결과물
SELECT * FROM salaries
WHERE salary = ANY ( SELECT salary FROM salaries WHERE emp_no = 10010 );

SELECT * FROM salaries
WHERE salary in ( SELECT salary FROM salaries WHERE emp_no = 10010 );


-- 480,870
SELECT * FROM salaries
WHERE salary = ALL ( SELECT salary FROM salaries WHERE emp_no = 10010 );


/* TODO: SALARIES 테이블에서 EMP_NO : 10010  */

-- 오름차순 (위에서 아래로 값이 커진다.) ASC
-- 내림차순  (위에서 아래로 값이 작아진다.) DESC
SELECT * FROM salaries
WHERE emp_no IN (499988, 499987, 499986)
ORDER BY emp_no DESC, salary DESC;

/* 
employees 테이블에서 나이는 내림차순으로 
성별은 여성이 위로, 남성이 아래로 나오게 select 하시오.
*/
SELECT * FROM employees
ORDER BY birth_date DESC, gender DESC;







