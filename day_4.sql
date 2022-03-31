
CREATE TABLE t_member_hobbit (
	memberid CHAR(8) NOT NULL,
	hobbit_id INT(10) UNSIGNED NOT NULL,
	PRIMARY KEY (memberid, hobbit_id), 
	FOREIGN KEY (memberid) REFERENCES membertbl(memberid),
	FOREIGN KEY (hobbit_id) REFERENCES t_hobbit_2(hobbit_id)
);
test
SELECT * FROM t_member_hobbit;

SELECT * FROM information_schema.TABLE_CONSTRAINTS 
WHERE TABLE_NAME = 't_member_hobbit';

INSERT INTO t_member_hobbit ( memberid, hobbit_id ) VALUES ( '1', 1 );
INSERT INTO t_member_hobbit ( memberid, hobbit_id ) VALUES ( '1', 2 );
INSERT INTO t_member_hobbit ( memberid, hobbit_id ) VALUES ('5', 3), ('5', 7), ('5', 8);
INSERT INTO t_member_hobbit ( memberid, hobbit_id ) VALUES ( '7', 6 );

DROP TABLE membertbl;


SELECT B.memberName, B.memberAddress, C.NAME
  FROM  t_member_hobbit A
 INNER JOIN t_hobbit_2 C
    ON A.hobbit_id = C.hobbit_id
 INNER JOIN membertbl B
    ON A.memberid = B.memberID;

USE `employees`;
-- 사원번호, 사원명, 직책, 부서이름 나타나게 select

SELECT A.emp_no, A.first_name, A.last_name, C.dept_name, D.title
  FROM employees A
 INNER JOIN dept_emp B
    ON A.emp_no = B.emp_no
 INNER JOIN departments C
    ON B.dept_no = C.dept_no
 INNER JOIN titles D
    ON A.emp_no = D.emp_no;
    
-- 남녀 사원의 평균 연봉   
SELECT A.gender, AVG(B.salary) 'avg_salary'
FROM employees A
INNER JOIN salaries B
ON A.emp_no = B.emp_no
GROUP BY A.gender;


-- 부서별 가장 높은 개인 평균 연봉 값;

-- 개인마다 평균 연봉 구함 > 개인을 부서로 조인 > 부서별로 그룹 묶음  > 가장 높은 평균연봉 값
SELECT z.dept_no, MAX(Z.avg_salary) AS max_salary
FROM (
	SELECT B.dept_no, A.emp_no, AVG(A.salary) AS avg_salary
	FROM salaries A
	INNER JOIN dept_emp B
	ON A.emp_no = B.emp_no
	GROUP BY B.emp_no
) Z
GROUP BY Z.dept_no;

-- 부서별 부서이름, 연봉 평균값, max값, min값 나오게 해주세요.
SELECT B.dept_no, C.dept_name, AVG(A.salary), MAX(A.salary), MIN(A.salary)
FROM salaries A
INNER JOIN dept_emp B
ON A.emp_no = B.emp_no
INNER JOIN departments C
ON B.dept_no = C.dept_no
GROUP BY B.dept_no, C.dept_name; -- mysql은 C.dept_name 생략가능 but 오라클은 불가능
SELECT A.emp_no, AVG(A.salary), C.dept_name 
FROM salaries A
INNER JOIN dept_emp B
ON A.emp_no = B.emp_no
INNER JOIN departments C
ON B.dept_no = C.dept_no
GROUP BY A.emp_no
ORDER BY AVG(A.salary) desc
LIMIT 1;
-- 전체 개인 평균 연봉 중에서 가장 높은 연봉 받는 사람의 부서 찾아내는거















