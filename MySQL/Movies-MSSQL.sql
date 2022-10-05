USE master
GO
if exists (select * from sysdatabases where name='movies')
	DROP DATABASE movies
GO

CREATE DATABASE movies
GO
USE movies
GO

----- Create Tables -----

CREATE TABLE MOVIE (
 TITLE VARCHAR(255) NOT NULL,
 YEAR INTEGER NOT NULL,
 LENGTH INTEGER,
 INCOLOR CHAR(1),
 STUDIONAME CHAR(50),
 PRODUCERC# INTEGER
);

CREATE TABLE MOVIESTAR (
 NAME CHAR(30) NOT NULL,
 ADDRESS VARCHAR(255),
 GENDER CHAR(1),
 BIRTHDATE DATETIME
);

CREATE TABLE STARSIN (
    MOVIETITLE VARCHAR(255) NOT NULL,
    MOVIEYEAR INTEGER NOT NULL,
    STARNAME CHAR(30) NOT NULL
);

CREATE TABLE MOVIEEXEC (
    CERT# INTEGER NOT NULL,
    NAME CHAR(30),
    ADDRESS VARCHAR(255),
    NETWORTH INTEGER
);

CREATE TABLE STUDIO (
    NAME CHAR(50) NOT NULL,
    ADDRESS VARCHAR(255),
    PRESC# INTEGER
);

----- Create Constraints -----
ALTER TABLE MOVIE ADD CONSTRAINT PK_MOVIE PRIMARY KEY(TITLE,YEAR);

ALTER TABLE MOVIESTAR ADD CONSTRAINT PK_MOVIESTAR PRIMARY KEY(NAME);

ALTER TABLE MOVIEEXEC ADD CONSTRAINT PK_MOVIEEXEC PRIMARY KEY(CERT#);

ALTER TABLE STUDIO ADD CONSTRAINT PK_STUDIO PRIMARY KEY(NAME);

ALTER TABLE STARSIN ADD CONSTRAINT PK_STARSIN PRIMARY KEY(MOVIETITLE,MOVIEYEAR,STARNAME);

ALTER TABLE MOVIE ADD CONSTRAINT FK_MOVIE_MOVIEEXEC FOREIGN KEY(PRODUCERC#) REFERENCES MOVIEEXEC(CERT#);

ALTER TABLE MOVIE ADD CONSTRAINT FK_MOVIE_STUDIO FOREIGN KEY(STUDIONAME) REFERENCES STUDIO(NAME);

ALTER TABLE STARSIN ADD CONSTRAINT FK_STARSIN_MOVIE FOREIGN KEY(MOVIETITLE, MOVIEYEAR) REFERENCES MOVIE(TITLE, YEAR);

ALTER TABLE STARSIN ADD CONSTRAINT FK_STARSIN_MOVIESTAR FOREIGN KEY(STARNAME) REFERENCES MOVIESTAR(NAME);

------- Insert Studio ------------
INSERT INTO STUDIO
  VALUES ('Disney','500 S. Buena Vista Street',1);

INSERT INTO STUDIO
  VALUES ('USA Entertainm.','', 2);

INSERT INTO STUDIO
  VALUES ('Fox','10201 Pico Boulevard', 3);

INSERT INTO STUDIO
  VALUES ('Paramount','5555 Melrose Ave', 4);

INSERT INTO STUDIO
  VALUES ('MGM','MGM Boulevard', 5);
  
------- Insert MovieExec ------------  
INSERT INTO MOVIEEXEC (NAME, ADDRESS, CERT#, NETWORTH)
  VALUES ('George Lucas', 'Oak Rd.', 555, 200000000);

INSERT INTO MOVIEEXEC (NAME, ADDRESS, CERT#, NETWORTH)
  VALUES ('Ted Turner', 'Turner Av.', 333, 125000000);

INSERT INTO MOVIEEXEC (NAME, ADDRESS, CERT#, NETWORTH)
  VALUES ('Stephen Spielberg', '123 ET road', 222, 100000000);

INSERT INTO MOVIEEXEC (NAME, ADDRESS, CERT#, NETWORTH)
  VALUES ('Merv Griffin', 'Riot Rd.', 199, 112000000);

INSERT INTO MOVIEEXEC (NAME, ADDRESS, CERT#, NETWORTH)
  VALUES ('Calvin Coolidge', 'Fast Lane', 123, 20000000);

------- Insert Movie ------------
INSERT INTO MOVIE
  VALUES ('Pretty Woman', 1990, 119, 'Y', 'Disney', 199);

INSERT INTO MOVIE
  VALUES ('The Man Who Wasn''t There', 2001, 116, 'N', 'USA Entertainm.',
    555);

INSERT INTO MOVIE
  VALUES ('Logan''s run', 1976, NULL, 'Y', 'Fox', 333);

INSERT INTO MOVIE
  VALUES ('Star Wars', 1977, 124, 'Y', 'Fox', 555);

INSERT INTO MOVIE
  VALUES ('Empire Strikes Back', 1980, 111, 'Y', 'Fox', 555);

INSERT INTO MOVIE
  VALUES ('Star Trek', 1979, 132, 'Y', 'Paramount', 222);

INSERT INTO MOVIE
  VALUES ('Star Trek: Nemesis', 2002, 116, 'Y', 'Paramount', 123);

INSERT INTO MOVIE
  VALUES ('Terms of Endearment', 1983, 132, 'Y', 'MGM', 123);

INSERT INTO MOVIE
  VALUES ('The Usual Suspects', 1995, 106, 'Y', 'MGM', 199);

INSERT INTO MOVIE
  VALUES ('Gone With the Wind', 1938, 238, 'Y', 'MGM', 123);

------- Insert MovieStar ------------

INSERT INTO MOVIESTAR
  VALUES ('Jane Fonda', 'Turner Av.', 'F', '1977-07-07');

INSERT INTO MOVIESTAR
  VALUES ('Alec Baldwin', 'Baldwin Av.', 'M', '1977-07-06');

INSERT INTO MOVIESTAR
  VALUES ('Kim Basinger', 'Baldwin Av.', 'F', '1979-07-05');

INSERT INTO MOVIESTAR
  VALUES ('Harrison Ford', 'Prefect Rd.', 'M', '1955-05-05');

INSERT INTO MOVIESTAR
  VALUES ('Debra Winger', 'A way', 'F', '1978-06-05');

INSERT INTO MOVIESTAR
  VALUES ('Jack Nicholson', 'X path', 'M', '1949-05-05');
  
INSERT INTO MOVIESTAR
  VALUES ('Sandra Bullock', 'X path', 'F', '1948-12-05');

------- Insert StarsIn ------------
INSERT INTO STARSIN
  VALUES ('Star Wars', 1977, 'Kim Basinger');

INSERT INTO STARSIN
  VALUES ('Star Wars', 1977, 'Alec Baldwin');

INSERT INTO STARSIN
  VALUES ('Star Wars', 1977, 'Harrison Ford');

INSERT INTO STARSIN
  VALUES ('Empire Strikes Back', 1980, 'Harrison Ford');

INSERT INTO STARSIN
  VALUES ('The Usual Suspects', 1995, 'Jack Nicholson');

INSERT INTO STARSIN
  VALUES ('Terms of Endearment', 1983, 'Jane Fonda');

INSERT INTO STARSIN
  VALUES ('Terms of Endearment', 1983, 'Jack Nicholson');

INSERT INTO STARSIN
  VALUES ('The Usual Suspects', 1995, 'Sandra Bullock')

  -------8.3 Modifications-example---------

  --1.1--
INSERT INTO MOVIESTAR
	VALUES ('Nicole Kidman', NULL, 'F', '1967-06-20');

	DELETE FROM MOVIESTAR WHERE MOVIESTAR.NAME = 'Nicole Kidman'

 --1.2--
UPDATE MOVIE SET PRODUCERC# = NULL WHERE PRODUCERC# = (SELECT MOVIEEXEC.CERT# FROM MOVIEEXEC WHERE MOVIEEXEC.NETWORTH < 30000000);
DELETE FROM MOVIEEXEC WHERE MOVIEEXEC.NETWORTH < 30000000;


--1.3---
DELETE FROM MOVIESTAR WHERE MOVIESTAR.ADDRESS IS NULL;

SELECT * FROM MOVIE
SELECT * FROM MOVIEEXEC
SELECT * FROM MOVIESTAR

--SUBQUERIES--
--1--
SELECT MOVIESTAR.NAME FROM MOVIESTAR WHERE MOVIESTAR.NAME IN (SELECT MOVIEEXEC.NAME FROM MOVIEEXEC WHERE(MOVIEEXEC.NETWORTH > 10000000));

--2--
SELECT MOVIESTAR.NAME FROM MOVIESTAR WHERE MOVIESTAR.NAME NOT IN  (SELECT MOVIEEXEC.NAME FROM MOVIEEXEC);

--3--
SELECT MOVIE.TITLE FROM MOVIE WHERE MOVIE.LENGTH > (SELECT MOVIE.LENGTH FROM MOVIE WHERE(MOVIE.TITLE = 'Star Wars')); 

--4--
SELECT MOVIE.TITLE, MOVIEEXEC.NAME FROM MOVIE 
JOIN MOVIEEXEC ON
MOVIE.PRODUCERC# = MOVIEEXEC.CERT#
WHERE MOVIEEXEC.NAME IN 
(SELECT MOVIEEXEC.NAME FROM MOVIEEXEC
WHERE(MOVIEEXEC.NETWORTH > 112000000));


--JOINS--

--1--
SELECT MOVIEEXEC.NAME, MOVIE.TITLE FROM MOVIE JOIN
MOVIEEXEC ON 
MOVIE.PRODUCERC# = MOVIEEXEC.CERT#
WHERE (MOVIEEXEC.NAME = 'George Lucas');

--2--
SELECT MOVIEEXEC.NAME FROM MOVIE JOIN
MOVIEEXEC ON 
MOVIE.PRODUCERC# = MOVIEEXEC.CERT#
JOIN STARSIN ON
MOVIE.TITLE = STARSIN.MOVIETITLE
WHERE NOT(STARSIN.STARNAME = 'Harrison Ford');

--3--
SELECT MOVIE.STUDIONAME, STARSIN.STARNAME FROM STUDIO JOIN 
MOVIE ON
STUDIO.NAME = MOVIE.STUDIONAME JOIN 
STARSIN ON
STARSIN.MOVIETITLE = MOVIE.TITLE
ORDER BY STUDIONAME


--4--
SELECT STARSIN.STARNAME FROM MOVIEEXEC JOIN 
MOVIE ON
MOVIEEXEC.CERT# = MOVIE.PRODUCERC# JOIN
STARSIN ON
MOVIE.TITLE = STARSIN.MOVIETITLE WHERE MOVIEEXEC.NETWORTH IN
(SELECT MAX(MOVIEEXEC.NETWORTH) FROM MOVIEEXEC);

--5-- 
SELECT MOVIESTAR.NAME FROM MOVIESTAR LEFT JOIN 
STARSIN ON
STARSIN.STARNAME = MOVIESTAR.NAME
WHERE(STARSIN.STARNAME IS NULL);


--SIMPLE QUERIES--
--1--
SELECT STUDIO.ADDRESS FROM STUDIO WHERE(STUDIO.NAME = 'Disney');

--2--
SELECT MOVIESTAR.BIRTHDATE FROM MOVIESTAR WHERE (MOVIESTAR.NAME = 'Jack Nicholson');

--3-- 
SELECT STARSIN.STARNAME FROM STARSIN WHERE (MOVIEYEAR = 1980 AND STARSIN.MOVIETITLE LIKE '%Knight%');

--4--
SELECT MOVIEEXEC.NAME FROM MOVIEEXEC WHERE (MOVIEEXEC.NETWORTH > 10000000);

--5--
SELECT MOVIESTAR.NAME FROM MOVIESTAR WHERE(MOVIESTAR.GENDER = 'M' OR MOVIESTAR.ADDRESS LIKE '%Prefect Rd.%');

--MANY TO MANY RELATIONS--

--1--
SELECT STARSIN.STARNAME FROM STARSIN JOIN
MOVIESTAR ON 
STARSIN.STARNAME = MOVIESTAR.NAME
WHERE(MOVIESTAR.GENDER = 'M' AND STARSIN.MOVIETITLE = 'The Usual Suspects');

--2--
SELECT STARSIN.STARNAME FROM STARSIN JOIN 
MOVIE ON
STARSIN.MOVIETITLE = MOVIE.TITLE
WHERE(MOVIE.YEAR = 1995 AND MOVIE.STUDIONAME = 'MGM');

--3--
SELECT DISTINCT MOVIEEXEC.NAME FROM MOVIEEXEC
JOIN MOVIE ON 
MOVIEEXEC.CERT# = MOVIE.PRODUCERC#
WHERE (MOVIE.STUDIONAME = 'MGM');

--4--
SELECT MOVIE.TITLE FROM MOVIE WHERE MOVIE.LENGTH > (SELECT MOVIE.LENGTH FROM MOVIE WHERE (MOVIE.TITLE = 'Star Wars'));

--5--
SELECT MOVIEEXEC.NAME FROM MOVIEEXEC WHERE MOVIEEXEC.NETWORTH > (SELECT MOVIEEXEC.NETWORTH FROM MOVIEEXEC WHERE(MOVIEEXEC.NAME = 'Stephen Spielberg'));

--6--
SELECT MOVIE.TITLE FROM MOVIE JOIN MOVIEEXEC ON
MOVIE.PRODUCERC# = MOVIEEXEC.CERT#
WHERE MOVIEEXEC.NAME IN (SELECT MOVIEEXEC.NAME FROM MOVIEEXEC
WHERE MOVIEEXEC.NETWORTH > (SELECT MOVIEEXEC.NETWORTH FROM MOVIEEXEC 
WHERE(MOVIEEXEC.NAME = 'Stephen Spielberg')));

