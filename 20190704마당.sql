/*equi join ������

--���̺� �����̽� ����� ����
create tablespace ���̺����̽� �̸�
                       datafile'���������� ���'
                       size �ʱ� ������
                      autoextend on next �ڵ�����������
                      maxsize �ִ������;

create tablespace madang
datafile 'D:\honggildong\madang.dbf'
size 50M
autoextend on next 10M 
maxsize unlimited;


create user ���̵� identified by ��й�ȣ 
default talbespace ���̺����̽� �̸�;

create user madang identified by madang 
default tablespace madang;

���� �ο��ϱ�
grant ���Ѹ���Ʈ to ���̵�;
connect : �α��α���
resource : �ڿ��� ����� �� �ִ� ����
dba : db ������ ����

grant connect, resource, dba to madang;

����Ŭ ����
�׽�Ʈ ���� ORA-01045


--���̺� �����ϱ�
create table table_name (
column_1 data_type,
column_2 data_type,
...
);


create table book(
   bookid number not null,
   bookname varchar2(50) not null,
   publisher varchar2(10) not null,
   price number,
   primary key(bookid)
);

constraint : ��������
*/



create table book(
   bookid number not null,
   bookname varchar2(50) not null,
   publisher varchar2(10) not null,
   price number,
   primary key(bookid)
);

/*
insert into tablename
VALUES(....�� ����Ʈ);
*/

insert into book values(1, '���������', '������', '14000');
insert into book (bookid, bookname, publisher)
        values(2, '�����', '�Ѻ�');
    
update book
set price = 20000
where bookid = 2;

delete from book
where bookid = 1;

rollback;

drop table book;

select * 
from book;


--�ܷ�Ű�� �����ϴ� ���̺��� ����
create table ...(
��Ű�Ӽ���,
....,
�ܷ�Ű�Ӽ���,
.....,
primary key(��Ű�Ӽ���),
foreign key �ܷ�Ű�Ӽ��� references ���̺��̸�[�Ӽ��̸�]
);


create table book (
    bookid number not null,
    bookname varchar2(50) not null,
    publisher varchar2(20) not null,
    price number,
    primary key(bookid)
    );
    
insert into book values (1, '�౸�� ����', '�½�����', '7000');
insert into book values (2, '�౸�ƴ� ����', '������', '13000');
insert into book values (3, '�౸�� ����', '���ѹ̵��', '22000');
insert into book values (4, '���� ���̺�', '���ѹ̵��', '35000');
insert into book values (5, '�ǰ� ����', '�½�����', '8000');
insert into book values (6, '���� �ܰ躰���', '�½�����', '6000');
insert into book values (7, '�߱��� �߾�', '�̻�̵��', '20000');
insert into book values (8, '�߱��� ��Ź��', '�̻�̵��', '13000');
insert into book values (9, '�ø��� �̾߱�', '�Ｚ��', '7500');
insert into book values (10, 'Olympic Champions', 'Pearson', '13000');
    
    
create table customer(
    custid number not null,
    name varchar2(20) not null,
    address varchar2(60) not null,
    phone varchar2(20),
    primary key (custid)
    );
 
 
    
insert into Customer values (1, '������', '���� ��ü��Ÿ', '000-5000-0001');
insert into Customer values (2, '�迬��', '���ѹα� ����', '000-6000-0001');
insert into Customer values (3, '��̶�', '���ѹα� ������', '000-7000-0001');
insert into Customer values (4, '�߽ż�', '�̱� Ŭ������', '000-8000-0001');
insert into Customer (custid, name, address) values (5, '�ڼ���', '���ѹα� ����');  

    
create table orders (
    orderid number not null,
    custid number not null,
    bookid number not null,
    saleprice number not null,
    orderdate date,
    primary key (orderid),
    foreign key (custid) references customer(custid),
    foreign key (bookid) references book(bookid)
    );


insert into orders values (1, 1, 1, 6000, to_date('2014-07-01', 'yyyy-mm-dd'));
insert into orders values (2, 1, 3, 21000, to_date('2014-07-03', 'yyyy-mm-dd'));
insert into orders values (3, 2, 5, 8000, to_date('2014-07-03', 'yyyy-mm-dd'));
insert into orders values (4, 3, 6, 6000, to_date('2014-07-04', 'yyyy-mm-dd'));
insert into orders values (5, 4, 7, 20000, to_date('2014-07-05', 'yyyy-mm-dd'));
insert into orders values (6, 1, 2, 12000, to_date('2014-07-07', 'yyyy-mm-dd'));
insert into orders values (7, 4, 8, 13000, to_date('2014-07-07', 'yyyy-mm-dd'));
insert into orders values (8, 3, 10, 12000, to_date('2014-07-08', 'yyyy-mm-dd'));
insert into orders values (9, 2, 10, 7000, to_date('2014-07-09', 'yyyy-mm-dd'));
insert into orders values (10, 3, 8, 13000, to_date('2014-07-10', 'yyyy-mm-dd'));

commit; --�����ͺ��̽��� �ݿ���Ŵ

set auto off;

select * from customer;

insert into customer
values(6, 'ȫ�浿', '���ѹα� ����', null);
commit;

delete from customer where custid =6;
rollback; --commit �ǵ�����

    