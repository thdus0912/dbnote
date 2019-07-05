-- 한줄 주석
/*
전체 주석
*/

/*
SELECT [ALL | DISTINCT] COLUM_NAME
FROM TABLE_NAME
WHERE[조건식]
ORDER BY [ASC | DESC]
GROUP BY [속성] -- SELECT문의 결과를 그룹으로 만듦 
HAVING[조건식] -- 그룹을 만들 조건
*/

select employee_id, last_name, first_name
from employees;

--급여순으로 직원의 이름과 급여를 검색
select last_name, salary
from employees
order by salary;

--연산자 우선순위 ()안에 있는것 우선
SELECT last_name, 12*salary+100
FROM employees;

SELECT last_name, 12*(salary+100)
FROM employees;

--null값이 포함되어있는 연산 
--하나라도 null값을 가지면 연산결과는 무조건 null
select last_name, commission_pct
from employees;

SELECT last_name, 12 * salary * commission_pct
FROm employees;

--연결연산자 || 칼럼들을 이어서(연결해서or연속해서) 출력해줌
select last_name || first_name
from employees;

select last_name ||' ' || first_name
from employees;

select last_name ||' ' || first_name as "Name"
from employees;

select last_name || '는(은) 부서 ' || department_id || ' 에서 근무합니다.' as "근무부서확인"
from employees;

--중복행 제거 DISTINCT
select  department_id
from employees;

select  distinct department_id
from employees;

--WHERE 절
SELECT employee_id, last_name, department_id
FROM employees
WHERE department_id = 90;

SELECT employee_id, job_id, last_name
FROM employees
WHERE last_name = 'King';

--LIKE %, _자리를 나타냄
SELECT employee_id, job_id, last_name
FROM employees
WHERE last_name like 'K%';

SELECT employee_id, last_name
FROM employees
WHERE last_name LIKE '_a%';

--비교연산자(= > < <>) 논리연산자(and or not)
SELECT employee_id, last_name, salary
FROM employees
WHERE salary >= 2500 and salary <=3000;

--between a and b(a와 b사이의 것, a이상 b이하)
SELECT employee_id, last_name, salary
FROM employees
WHERE salary BETWEEN 2500 and 3000;

--in ()안에 있는것들 중 하나와 일치하는것
SELECT employee_id, last_name, salary
FROM employees
where salary=2400 or salary=2500 or salary=3000;
-- = WHERE salary IN (2400, 2500, 3000);

--null
SELECT employee_id, last_name, commission_pct
FROM employees
where commission_pct is null;

SELECT employee_id, last_name name --as 생략가능
FROM employees
ORDER BY name;

SELECT employee_id, last_name, department_id, salary
FROM employees
ORDER BY department_id, salary DESC, last_name; --순서대로 첫번째것이 같으면 두번째 것으로 정렬~


--단일행 함수(문자함수)
select lower(last_name), last_name
from employees;

select concat(first_name ,last_name)
from employees;

select last_name, lpad(salary, 10, '*')
from employees;

select last_name, hire_date, to_char(hire_date, 'yyyy mon dd dy')
from employees;

select last_name, nvl(manager_id, 0)
from employees;

select employee_id, last_name, manager_id, nvl2(manager_id, '부서있음', '부서없음')배치부서
from employees;

SELECT last_name, NULLIF(LENGTH(first_name), LENGTH(last_name))name
FROM employees ;

select last_name, first_name
from employees
where last_name = 'Chen';

select last_name, first_name
from employees
where rownum <= 10;

--그룹함수
SELECT AVG(salary), SUM(salary), MAX(salary), MIN(salary)
FROM employees
WHERE department_id = 90 ;

SELECT MAX(hire_date), MIN(hire_date)
FROM employees ;

SELECT COUNT(employee_id)
FROM employees
WHERE department_id = 60 ;

SELECT AVG(commission_pct)
FROM employees ;

SELECT AVG (NVL (commission_pct, 0))
FROM employees ;

SELECT department_id, to_char(round(AVG(salary), 3), '999,999,999')
FROM employees
GROUP BY department_id ;

SELECT job_id, AVG(salary)
FROM employees 
group by job_id;

SELECT job_id, AVG(salary)
FROM employees
GROUP BY job_id
HAVING AVG(salary) > 4000 ;

--이퀴 조인(동등조인)
select c.country_name, r.region_name
from countries c, regions r
where c.region_id = r.region_id;

SELECT e.employee_id, e.last_name, e.department_id, 
       d.department_id, d.department_name 
FROM employees e, departments d 
WHERE e.department_id = d.department_id 
      AND last_name = 'King';
      
SELECT e.employee_id, e.last_name, e.department_id,
       d.department_name, d.location_id, l.city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
      AND d.location_id = l.location_id ;
      
SELECT last_name, department_name
FROM employees NATURAL JOIN departments ;

SELECT last_name, department_name
FROM employees JOIN departments
USING (department_id);

--outer join (left-왼쪽을 기준으로 오른쪽을 배재, right-오른쪽을 기준으로 왼쪽을 배재, full-왼쪽&오른쪽&중복되는것)
/*select 속성
  from 테이블1 (left/right/full join) 테이블2
  on(조인 조건)
  where (검색 조건);
*/
SELECT e.last_name, e.first_name, e.department_id, d.department_name
FROM employees e LEFT OUTER JOIN departments d
ON (e.department_id = d.department_id );

SELECT e.last_name, e.department_id, d.department_name
FROM employees e RIGHT OUTER JOIN departments d
ON (e.department_id = d.department_id );

SELECT e.last_name, e.first_name, e.department_id, d.department_name
FROM employees e FULL OUTER JOIN departments d
ON (e.department_id = d.department_id );
