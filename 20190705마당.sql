select bookname, price
from book;

select bookid, bookname, publisher, price
from book;

select publisher
from book;

select *
from book
where price < 20000;

select *
from book
where price between 10000 and 20000;

select * 
from book
where publisher in ('�½�����', '���ѹ̵��'); --in ()�ȿ� �ִ°͵� �� �ϳ��� ��ġ�ϴ°�

select bookname,publisher
from book
where bookname like '�౸�� ����';

select bookname, publisher
from book
where bookname like '%�౸%';

select * 
from book
where bookname like '_��%';

select *
from book
where bookname like '%�౸%' and price >= 20000;

select *
from book
order by bookname;

select *
from book
order by price, bookname;

select *
from book
order by price desc, publisher asc;

select sum(saleprice)
from orders;

select sum(saleprice)
from orders
where custid = 2;

select sum(saleprice), avg(saleprice), min(saleprice), max(saleprice)
from orders;

select count(*)
from orders;

select custid, count(*), sum(saleprice)
from orders
group by custid;

select custid, count(*)
from orders
where saleprice >= 8000
group by custid
having count(*) >= 2;

select *
from customer c, orders o
where c.custid = o.custid;

select name, saleprice
from customer c, orders o
where c.custid = o.custid;

select name, sum(saleprice)
from customer c, orders o
where c.custid = o.custid
group by name
order by name;

select name, bookname
from customer c, orders o, book b
where c.custid = o.custid and o.bookid = b.bookid;

select name, bookname
from customer c, book b, orders o
where c.custid = o.custid and o.bookid = b.bookid 
and o.saleprice = 20000;

--�ܺ�����
select name, saleprice
from customer left outer join orders
on customer.custid = orders.custid;

--****��������****
select bookname
from book
where  price = (select max(price)
        from book);

--**in ���� �� �� �ϳ��� ��ġ�ϴ� ��
select name
from customer
where custid in (select custid 
                 from orders);
        
select name
from customer
where custid in (select custid
                  from orders
                  where bookid in (select bookid
                                    from book
                                    where publisher = '���ѹ̵��'));
                                    
select b1.bookname
from book b1
where b1.price > (select avg(b2.price)
                from book b2
                where b2.publisher = b1.publisher);
----------���� ����---------



--���̺� ����, ���������� ��������...
create table ex(
    id number(3),
    name varchar(30) constraint cname_unique unique,
    salary number(7) constraint cname_check check(salary between 300 and 1000),
    primary key(id)
);

insert into ex values(1, 'ȫ�浿', 300);
insert into ex values(2, '�ڹ���', 2000);
insert into ex values(3, '������', 500);
select * from ex;
drop table ex;
--primary key = unique + not null
--unique = only unique

select constraint_name from user_constraints;

--���̺� �̸��ٲٱ�
rename example to ex;

--���̺� Į�� �߰�
--alter table ���̺��̸� add(���ο� Į���̸� Ÿ��)
alter table ex add(dept_id number(3));
desc ex;


--Į������
alter table ex modify(name varchar(50));

--Į������
alter table ex drop column dept_id;

--Į�� �̸�����
alter table ex rename column salary to pay;


--�μ�����
/* ��Į�� �μ� ����
select ���� ��ġ
ex)
    select custid, <<(select name
                    from customer cs
                    where cs.custid=od.custid)>>, sum(saleprice)
    from orders od
    group by custid;
*/

/*�ζ��� ��
from ���� ��ġ
ex)
    select cs.name, sum(od.saleprice) "total"
    from    (select custid, name
             from customer
             where custid <= 2) cs,
             orders od
    where cs.custid = od. custid
    group by cs.name;
*/