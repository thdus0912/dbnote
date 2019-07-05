/*equi join 교집합

--테이블 스페이스 만들기 구문
create tablespace 테이블스페이스 이름
                       datafile'데이터파일 경로'
                       size 초기 사이즈
                      autoextend on next 자동증가사이즈
                      maxsize 최대사이즈;

create tablespace madang
datafile 'D:\honggildong\madang.dbf'
size 50M
autoextend on next 10M 
maxsize unlimited;


create user 아이디 identified by 비밀번호 
default talbespace 테이블스페이스 이름;

create user madang identified by madang 
default tablespace madang;

권한 부여하기
grant 권한리스트 to 아이디;
connect : 로그인권한
resource : 자원을 사용할 수 있는 권한
dba : db 관리자 권한

grant connect, resource, dba to madang;

오라클 오류
테스트 실패 ORA-01045


--테이블 생성하기
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

constraint : 제약조건
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
VALUES(....값 리스트);
*/

insert into book values(1, '레미제라블', '대한출', '14000');
insert into book (bookid, bookname, publisher)
        values(2, '장발장', '한빛');
    
update book
set price = 20000
where bookid = 2;

delete from book
where bookid = 1;

rollback;

drop table book;

select * 
from book;


--외래키를 포함하는 테이블의 정의
create table ...(
주키속성명,
....,
외래키속성명,
.....,
primary key(주키속성명),
foreign key 외래키속성명 references 테이블이름[속성이름]
);


create table book (
    bookid number not null,
    bookname varchar2(50) not null,
    publisher varchar2(20) not null,
    price number,
    primary key(bookid)
    );
    
insert into book values (1, '축구의 역사', '굿스포츠', '7000');
insert into book values (2, '축구아는 여자', '나무수', '13000');
insert into book values (3, '축구의 이해', '대한미디어', '22000');
insert into book values (4, '골프 바이블', '대한미디어', '35000');
insert into book values (5, '피겨 교본', '굿스포츠', '8000');
insert into book values (6, '역도 단계별기술', '굿스포츠', '6000');
insert into book values (7, '야구의 추억', '이상미디어', '20000');
insert into book values (8, '야구를 부탁해', '이상미디어', '13000');
insert into book values (9, '올림픽 이야기', '삼성당', '7500');
insert into book values (10, 'Olympic Champions', 'Pearson', '13000');
    
    
create table customer(
    custid number not null,
    name varchar2(20) not null,
    address varchar2(60) not null,
    phone varchar2(20),
    primary key (custid)
    );
 
 
    
insert into Customer values (1, '박지성', '영국 맨체스타', '000-5000-0001');
insert into Customer values (2, '김연아', '대한민국 서울', '000-6000-0001');
insert into Customer values (3, '장미란', '대한민국 강원도', '000-7000-0001');
insert into Customer values (4, '추신수', '미국 클리블랜드', '000-8000-0001');
insert into Customer (custid, name, address) values (5, '박세리', '대한민국 대전');  

    
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

commit; --데이터베이스에 반영시킴

set auto off;

select * from customer;

insert into customer
values(6, '홍길동', '대한민국 대전', null);
commit;

delete from customer where custid =6;
rollback; --commit 되돌리기

    