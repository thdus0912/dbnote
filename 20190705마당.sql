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
where publisher in ('굿스포츠', '대한미디어'); --in ()안에 있는것들 중 하나와 일치하는것

select bookname,publisher
from book
where bookname like '축구의 역사';

select bookname, publisher
from book
where bookname like '%축구%';

select * 
from book
where bookname like '_구%';

select *
from book
where bookname like '%축구%' and price >= 20000;

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

--외부조인
select name, saleprice
from customer left outer join orders
on customer.custid = orders.custid;

--****서브쿼리****
select bookname
from book
where  price = (select max(price)
        from book);

--**in 여러 값 중 하나와 일치하는 값
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
                                    where publisher = '대한미디어'));
                                    
select b1.bookname
from book b1
where b1.price > (select avg(b2.price)
                from book b2
                where b2.publisher = b1.publisher);
----------질의 연습---------



--테이블 생성, 제약조건이 전혀없는...
create table ex(
    id number(3),
    name varchar(30) constraint cname_unique unique,
    salary number(7) constraint cname_check check(salary between 300 and 1000),
    primary key(id)
);

insert into ex values(1, '홍길동', 300);
insert into ex values(2, '박문수', 2000);
insert into ex values(3, '성춘향', 500);
select * from ex;
drop table ex;
--primary key = unique + not null
--unique = only unique

select constraint_name from user_constraints;

--테이블 이름바꾸기
rename example to ex;

--테이블 칼럼 추가
--alter table 테이블이름 add(새로운 칼럼이름 타입)
alter table ex add(dept_id number(3));
desc ex;


--칼럼수정
alter table ex modify(name varchar(50));

--칼럼삭제
alter table ex drop column dept_id;

--칼럼 이름변경
alter table ex rename column salary to pay;


--부속질의
/* 스칼라 부속 질의
select 절에 위치
ex)
    select custid, <<(select name
                    from customer cs
                    where cs.custid=od.custid)>>, sum(saleprice)
    from orders od
    group by custid;
*/

/*인라인 뷰
from 절에 위치
ex)
    select cs.name, sum(od.saleprice) "total"
    from    (select custid, name
             from customer
             where custid <= 2) cs,
             orders od
    where cs.custid = od. custid
    group by cs.name;
*/