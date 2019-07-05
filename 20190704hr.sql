--���������� �ʿ��� ����
--���� ��� �浿�� �޿����� ���� �޿��� �޴� ����� �˻��϶�
--�ѹ��� ���� �������� �ذ��� �� ���� �� �ι��� ���ǰ� �ʿ��ϴ�.
--�̸� �ϳ��� ���� �������� ������ �� ���������� �����Ѵ�.
--1�ܰ�
SELECT salary 
      FROM employees
      WHERE last_name = 'Kochhar';
      
--2�ܰ�
SELECT last_name
FROM employees
WHERE salary >17000;

--����
SELECT last_name
FROM employees
WHERE salary > (
      SELECT salary 
      FROM employees
      WHERE last_name = 'Kochhar');

--1�ܰ�
SELECT department_id
      FROM employees
      WHERE employee_id = 101;

--2�ܰ�
SELECT salary
      FROM employees
      WHERE employee_id = 141;

--3�ܰ�
SELECT last_name, department_id, salary 
FROM employees
WHERE department_id =90 and salary > 3500;

--����
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
      
--1�ܰ�
SELECT MAX (salary)
     FROM employees;
    
--2�ܰ�
SELECT last_name, salary 
FROM employees
WHERE salary = 24000;
     
--����
SELECT last_name, salary 
FROM employees
WHERE salary = (
     SELECT MAX (salary)
     FROM employees);


--�μ��� ���� �޿��� �˻��ϵ� �μ����� 60�� �μ���
--���� �޿����ٴ� ū ���� �˻��϶�
--���������� ������� �ʰ� �Ѵٸ�
--����, �μ� ���̵� 60�� �μ��� ���� �޿��� �˻��Ѵ�.
select MIN(salary)
from employees
where department_id = 60;

--�� ����, �ռ� �˻��� ������ ū �ּұ޿��� ���� �μ����
--�� �μ��� �ּ� �޿��� ����Ѵ�.
select department_id, MIN(salary)
from employees
group by department_id
HAVING min(salary) >4200;

--������ ���Ǹ� ���������� �̿��ϸ�
SELECT department_id, MIN (salary) 
FROM employees
GROUP BY department_id
HAVING MIN (salary) > (
    SELECT MIN (salary)
    FROM employees
    WHERE department_id = 60);

--�޿� < any (1000,200,300)
--any �� �߿� �Ѱ��� ��Ҷ� �޿����� ũ���
--�޿� < all (100,200,300)
--all ��� ��Һ��� �޿��� �������
--��������� 100���� �۾ƾ� ��

--1�ܰ�
select distinct department_id
from employees;
--2�ܰ�
select max(salary)
from employees
where department_id = 60;
--3�ܰ�
select department_id, max(salary)
from employees
group by department_id;
--�������� Ȱ��
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


