-- ���� �ּ�
/*
��ü �ּ�
*/

/*
SELECT [ALL | DISTINCT] COLUM_NAME
FROM TABLE_NAME
WHERE[���ǽ�]
ORDER BY [ASC | DESC]
GROUP BY [�Ӽ�] -- SELECT���� ����� �׷����� ���� 
HAVING[���ǽ�] -- �׷��� ���� ����
*/

select employee_id, last_name, first_name
from employees;

--�޿������� ������ �̸��� �޿��� �˻�
select last_name, salary
from employees
order by salary;

--������ �켱���� ()�ȿ� �ִ°� �켱
SELECT last_name, 12*salary+100
FROM employees;

SELECT last_name, 12*(salary+100)
FROM employees;

--null���� ���ԵǾ��ִ� ���� 
--�ϳ��� null���� ������ �������� ������ null
select last_name, commission_pct
from employees;

SELECT last_name, 12 * salary * commission_pct
FROm employees;

--���Ῥ���� || Į������ �̾(�����ؼ�or�����ؼ�) �������
select last_name || first_name
from employees;

select last_name ||' ' || first_name
from employees;

select last_name ||' ' || first_name as "Name"
from employees;

select last_name || '��(��) �μ� ' || department_id || ' ���� �ٹ��մϴ�.' as "�ٹ��μ�Ȯ��"
from employees;

--�ߺ��� ���� DISTINCT
select  department_id
from employees;

select  distinct department_id
from employees;

--WHERE ��
SELECT employee_id, last_name, department_id
FROM employees
WHERE department_id = 90;

SELECT employee_id, job_id, last_name
FROM employees
WHERE last_name = 'King';

--LIKE %, _�ڸ��� ��Ÿ��
SELECT employee_id, job_id, last_name
FROM employees
WHERE last_name like 'K%';

SELECT employee_id, last_name
FROM employees
WHERE last_name LIKE '_a%';

--�񱳿�����(= > < <>) ��������(and or not)
SELECT employee_id, last_name, salary
FROM employees
WHERE salary >= 2500 and salary <=3000;

--between a and b(a�� b������ ��, a�̻� b����)
SELECT employee_id, last_name, salary
FROM employees
WHERE salary BETWEEN 2500 and 3000;

--in ()�ȿ� �ִ°͵� �� �ϳ��� ��ġ�ϴ°�
SELECT employee_id, last_name, salary
FROM employees
where salary=2400 or salary=2500 or salary=3000;
-- = WHERE salary IN (2400, 2500, 3000);

--null
SELECT employee_id, last_name, commission_pct
FROM employees
where commission_pct is null;

SELECT employee_id, last_name name --as ��������
FROM employees
ORDER BY name;

SELECT employee_id, last_name, department_id, salary
FROM employees
ORDER BY department_id, salary DESC, last_name; --������� ù��°���� ������ �ι�° ������ ����~


--������ �Լ�(�����Լ�)
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

select employee_id, last_name, manager_id, nvl2(manager_id, '�μ�����', '�μ�����')��ġ�μ�
from employees;

SELECT last_name, NULLIF(LENGTH(first_name), LENGTH(last_name))name
FROM employees ;

select last_name, first_name
from employees
where last_name = 'Chen';

select last_name, first_name
from employees
where rownum <= 10;

--�׷��Լ�
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

--���� ����(��������)
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

--outer join (left-������ �������� �������� ����, right-�������� �������� ������ ����, full-����&������&�ߺ��Ǵ°�)
/*select �Ӽ�
  from ���̺�1 (left/right/full join) ���̺�2
  on(���� ����)
  where (�˻� ����);
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
