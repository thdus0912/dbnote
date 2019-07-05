--서브쿼리가 필요한 이유
--예를 들어 길동의 급여보다 많은 급여를 받는 사람을 검색하라
--한번의 질의 구문으로 해결할 수 없을 때 두번의 질의가 필요하다.
--이를 하나의 질의 구문으로 구성할 때 서브쿼리를 구성한다.
--1단계
SELECT salary 
      FROM employees
      WHERE last_name = 'Kochhar';
      
--2단계
SELECT last_name
FROM employees
WHERE salary >17000;

--최종
SELECT last_name
FROM employees
WHERE salary > (
      SELECT salary 
      FROM employees
      WHERE last_name = 'Kochhar');

--1단계
SELECT department_id
      FROM employees
      WHERE employee_id = 101;

--2단계
SELECT salary
      FROM employees
      WHERE employee_id = 141;

--3단계
SELECT last_name, department_id, salary 
FROM employees
WHERE department_id =90 and salary > 3500;

--최종
SELECT last_name, department_id, salary 
FROM employees
WHERE department_id = (
      SELECT department_id
      FROM employees
      WHERE employee_id = 101)
AND salary > (
      SELECT salary
      FROM employees
      WHERE employee_id = 141);
      
--1단계
SELECT MAX (salary)
     FROM employees;
    
--2단계
SELECT last_name, salary 
FROM employees
WHERE salary = 24000;
     
--최종
SELECT last_name, salary 
FROM employees
WHERE salary = (
     SELECT MAX (salary)
     FROM employees);


--부서별 최저 급여를 검색하되 부서명이 60인 부서의
--최저 급여보다는 큰 값만 검색하라
--서브쿼리를 사용하지 않고 한다면
--먼저, 부서 아이디가 60인 부서의 최저 급여를 검색한다.
select MIN(salary)
from employees
where department_id = 60;

--그 다음, 앞서 검색된 값보다 큰 최소급여를 갖는 부서명과
--그 부서의 최소 급여를 출력한다.
select department_id, MIN(salary)
from employees
group by department_id
HAVING min(salary) >4200;

--동일한 질의를 서브쿼리를 이용하면
SELECT department_id, MIN (salary) 
FROM employees
GROUP BY department_id
HAVING MIN (salary) > (
    SELECT MIN (salary)
    FROM employees
    WHERE department_id = 60);

--급여 < any (1000,200,300)
--any 그 중에 한가지 요소라도 급여보다 크면됨
--급여 < all (100,200,300)
--all 모든 요소보다 급여가 작으면됨
--결과적으로 100보다 작아야 함

--1단계
select distinct department_id
from employees;
--2단계
select max(salary)
from employees
where department_id = 60;
--3단계
select department_id, max(salary)
from employees
group by department_id;
--서브쿼리 활용
select last_name, salary
from employees
where salary in (
   select max(salary)
   from employees
   group by department_id
);

select salary
from employees
where job_id = 'IT_PROG';

select last_name, job_id, salary
from employees 
where salary < any (
  select salary
  from employees
  where job_id = 'IT_PROG')
  and job_id <> 'IT_PROG';


