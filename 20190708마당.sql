--숫자함수
select abs(-78), abs(78)
from dual;

select round(4.875, 1)
from dual;

select custid  "고객번호", round(sum(saleprice)/count(*), -2) "평균금액"
from orders
group by custid;

--문자함수
select bookid, replace(bookname, '야구', '농구') bookname, publisher, price
from book;

select bookname "제목", length(bookname)"글자수", lengthb(bookname) "바이트 수"
from book
where publisher = '굿스포츠';

select substr(name, 1, 1) "성", count(*) "인원"
from customer
group by substr(name, 1, 1);

--날짜,시간함수
select orderid"주문번호", orderdate"주문일", orderdate+10 "확정"
from orders;

select orderid, to_char(orderdate, 'yyyy-mm-dd dy')"주문일", custid "고객번호", bookid "도서번호"
from orders
where orderdate=to_date('20140707', 'yyyymmdd');

select sysdate, to_char(sysdate, 'yyyy/mm/dd dy hh24:mi:ss') "sysdatd_1"
from dual;

select name,  nvl(phone, '연락처없음')
from customer;

select rownum"순번", custid, name, phone
from customer
where custid <=2;

--부속질의
select od.custid, (select name
        from customer cs
        where cs.custid=od.custid)"name", sum(saleprice)"total"
from orders od
group by od.custid;

alter table orders add bookname varchar2(40);

update orders
set bookname=(select bookname
              from book
              where book.bookid=orders.bookid);
select * from orders;


/* 뷰
하나 이상의 테이블을 합하여 만든 가상의 테이블
질의 구문으로만 구성되어진 가상의 테이블
실데이터x
장점
-편리성 및 재사용성 : 자주 사용되는 복잡한 질의를 뷰로 미리 정의해 놓을 수 있음 ->복잡한 질의를 간단히 작성
-보안성 : 각 사용자별로 필요한 데이터만 선발하여 보여줄 수 있음. 중요한 질의의 경우 질의내용을 암호화할 수 있음
-독립성 제공 : 미리 정의된 뷰를 일반 테이블처럼 사용할 수 있기 때문에 편리함. 또 사용자가 필요한 정보만 요구에
맞게 가공하여 뷰로 만들어 쓸 수 있음 -> 원본테이블이 구조가 변하여도 응용에 영향을 주지않도록하는 논리적 독립성 제공

1. 뷰의 종류
 단순뷰(simple view) -뷰생성 서브쿼리에 조인 조건없이 1개의 테이블로 부터 만들어지는 뷰(한개의 테이블에서 가져옴)
 복합뷰(complex view) - 뷰생성 서브쿼리에 여러개의 테이블 조인되어 생성되는 뷰(여러개의 테이블에서 가져옴, 조인이 포함되어있음)
 인라인뷰(inline view) - 해당 질의에서만 필요한 뷰일 경우 from절에 서브쿼리를 바로 적어서 사용하는 뷰(from절 안에서)

2. 뷰의 생성
 [create] or [create or replace] view 뷰네임
 as
 subquery
 [with read only]
*/

--뷰 생성 연습
create table o_tbl(a number, b number, c number);

create or replace view view1
as
select a,b
from o_tbl;

create or replace view view1
as
select b,c
from o_tbl
with read only;

insert into view1 values(1, 2);
select * from o_tbl;
select * from view1;

update o_tbl
set b=1
where a=1;

create or replace view view2
as
select a,b
from o_tbl
with read only;

insert into view2 values(99, 99);
select * from view2;

select * from user_views; --사용자가 만들어놓은 뷰들을 볼수있음
select * from tabs; --시스템내에 존재하는 테이블을 보여줌

create or replace view vw_Customer
as
select *
from customer
where address like '%대한민국%';

select * from vw_customer;

create or replace view vw_Customer(custid, name, address)
as select custid, name, address
from customer
where address like '%영국%';

drop view vw_customer;


--교제 252쪽
create or replace view highorders
as select b.bookid, b.bookname, c.name, b.publisher, o.saleprice
from book b, customer c, orders o
where o.custid = c.custid
and o.bookid= b.bookid
and o.saleprice >= 20000;

select * from highorders;

select bookname, name
from highorders;

create table test(no number);

begin
    for i in 1..10000 loop
    insert into test values(i);
    end loop;
    commit;
end;
/

select * from test;
select * from test where no=9999;

create index idx_test_no on test(no);

--인덱스의 상태를 조회하는 방법
ANALYZE index idx_test_no validate structure;
select (del_lf_rows_len / lf_rows_len) *100 balance
from index_stats
where name='IDX_TEST_NO';

delete from test
where no between 2500 and 6500;

ANALYZE index idx_test_no validate structure;
select (del_lf_rows_len / lf_rows_len) *100 balance
from index_stats
where name='IDX_TEST_NO';

--인덱스 리빌드
alter index idx_test_no rebuild;
ANALYZE index idx_test_no validate structure;
select (del_lf_rows_len / lf_rows_len) *100 balance
from index_stats
where name='IDX_TEST_NO';
