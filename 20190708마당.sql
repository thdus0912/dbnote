--�����Լ�
select abs(-78), abs(78)
from dual;

select round(4.875, 1)
from dual;

select custid  "����ȣ", round(sum(saleprice)/count(*), -2) "��ձݾ�"
from orders
group by custid;

--�����Լ�
select bookid, replace(bookname, '�߱�', '��') bookname, publisher, price
from book;

select bookname "����", length(bookname)"���ڼ�", lengthb(bookname) "����Ʈ ��"
from book
where publisher = '�½�����';

select substr(name, 1, 1) "��", count(*) "�ο�"
from customer
group by substr(name, 1, 1);

--��¥,�ð��Լ�
select orderid"�ֹ���ȣ", orderdate"�ֹ���", orderdate+10 "Ȯ��"
from orders;

select orderid, to_char(orderdate, 'yyyy-mm-dd dy')"�ֹ���", custid "����ȣ", bookid "������ȣ"
from orders
where orderdate=to_date('20140707', 'yyyymmdd');

select sysdate, to_char(sysdate, 'yyyy/mm/dd dy hh24:mi:ss') "sysdatd_1"
from dual;

select name,  nvl(phone, '����ó����')
from customer;

select rownum"����", custid, name, phone
from customer
where custid <=2;

--�μ�����
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


/* ��
�ϳ� �̻��� ���̺��� ���Ͽ� ���� ������ ���̺�
���� �������θ� �����Ǿ��� ������ ���̺�
�ǵ�����x
����
-���� �� ���뼺 : ���� ���Ǵ� ������ ���Ǹ� ��� �̸� ������ ���� �� ���� ->������ ���Ǹ� ������ �ۼ�
-���ȼ� : �� ����ں��� �ʿ��� �����͸� �����Ͽ� ������ �� ����. �߿��� ������ ��� ���ǳ����� ��ȣȭ�� �� ����
-������ ���� : �̸� ���ǵ� �並 �Ϲ� ���̺�ó�� ����� �� �ֱ� ������ ����. �� ����ڰ� �ʿ��� ������ �䱸��
�°� �����Ͽ� ��� ����� �� �� ���� -> �������̺��� ������ ���Ͽ��� ���뿡 ������ �����ʵ����ϴ� ���� ������ ����

1. ���� ����
 �ܼ���(simple view) -����� ���������� ���� ���Ǿ��� 1���� ���̺�� ���� ��������� ��(�Ѱ��� ���̺��� ������)
 ���պ�(complex view) - ����� ���������� �������� ���̺� ���εǾ� �����Ǵ� ��(�������� ���̺��� ������, ������ ���ԵǾ�����)
 �ζ��κ�(inline view) - �ش� ���ǿ����� �ʿ��� ���� ��� from���� ���������� �ٷ� ��� ����ϴ� ��(from�� �ȿ���)

2. ���� ����
 [create] or [create or replace] view �����
 as
 subquery
 [with read only]
*/

--�� ���� ����
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

select * from user_views; --����ڰ� �������� ����� ��������
select * from tabs; --�ý��۳��� �����ϴ� ���̺��� ������

create or replace view vw_Customer
as
select *
from customer
where address like '%���ѹα�%';

select * from vw_customer;

create or replace view vw_Customer(custid, name, address)
as select custid, name, address
from customer
where address like '%����%';

drop view vw_customer;


--���� 252��
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

--�ε����� ���¸� ��ȸ�ϴ� ���
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

--�ε��� ������
alter index idx_test_no rebuild;
ANALYZE index idx_test_no validate structure;
select (del_lf_rows_len / lf_rows_len) *100 balance
from index_stats
where name='IDX_TEST_NO';
