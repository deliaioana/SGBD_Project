DROP TABLE accounts;
CREATE TABLE accounts(
email Varchar2(50) NOT NULL, 
username Varchar2(50) NOT NULL,
pass Varchar2(50) NOT NULL
);

DROP TABLE tags;
CREATE TABLE tags(
id_tag NUMBER(20) NOT NULL,
tag_name varchar2(20) NOT NULL
);

DROP TABLE autograph_authors;
CREATE TABLE autograph_authors(
id_author NUMBER(38) NOT NULL, 
author VARCHAR2(50), 
area VARCHAR2(50),
importance integer not null
);

drop table items;
create table items(
    id_item number(38) not null,
    importance integer not null,
    item_name varchar2(50) not null
);

DROP TABLE exchange_autographs;
CREATE TABLE exchange_autographs(
    id_autograph NUMBER(38) NOT NULL,
    id_author NUMBER(38) NOT NULL,
    id_item NUMBER(38) NOT NULL,
    points NUMBER(10)
);

----------------------------------------------------------------------------------------------------
BEGIN
   INSERT INTO accounts VALUES ('oloeriud@yahoo.com', 'Delia', 'pass');
   INSERT INTO accounts VALUES ('ilinca.dumitrascu@gmail.com', 'Ilinca', 'pass');
   INSERT INTO accounts VALUES ('luigi@gmail.com', 'Luigi', 'pass');
   
   INSERT INTO autograph_authors VALUES (1, 'Lady Gaga', 'music', 10);
   INSERT INTO autograph_authors VALUES (2, 'Mihai Eminescu', 'literature', 2);
   INSERT INTO autograph_authors VALUES (3, 'Albert Einstein', 'science', 40);
   INSERT INTO autograph_authors VALUES (4, 'Travis Scott', 'music', 1);
   INSERT INTO autograph_authors VALUES (5, 'Marie Curie', 'science', 2);
   INSERT INTO autograph_authors VALUES (6, 'Isaac Newton', 'science', 3);
   
   INSERT INTO exchange_autographs VALUES (1, 4, 1, 1);
   INSERT INTO exchange_autographs VALUES (2, 5, 2, 2);
   INSERT INTO exchange_autographs VALUES (3, 6, 3, 3);
   
   INSERT INTO tags VALUES (1, 'cute');
   INSERT INTO tags VALUES (2, 'coffee');
   INSERT INTO tags VALUES (3, 'important');
   INSERT INTO tags VALUES (4, 'special');
   INSERT INTO tags VALUES (5, 'summer');
   
   insert into items values (1, 10, 'book');
   insert into items values (2, 15, 'hand');
   insert into items values (3, 5, 'paper');
   insert into items values (4, 7, 'piece of plastic');
   insert into items values (5, 30, 'golden plaque');
   
END;



