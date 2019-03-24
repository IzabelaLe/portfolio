/*Zagadnienia do projektu
 Opis projektu (cw2)- 1p  - wczesniej
 ERD dla projektu (cw4) - 3p- do kluczowej tabeli dodac  numer studenta - wczesniej (bylo 4p)
 DDL - 0.25p
 DML - 0.25p
 Przygotowac tresc pytan oraz odpowiedzi do wlasnej  bazy danych    
   - z wielu tabel  z warunkami where nie wliczajac warunków zlaczeniowych (minimum 2)  - 0.5
   - grupujace  - 1p
         na wielu tabelach  z dodatkowym (innym niz zlaczeniowy) warunkami where 
         na wielu tabelach  z warunkami  having  ( w having nie zadajemy warunku na kolumny grupujace)
         na wielu tabelach  z warunkami where i having 
  - 2 podzapytanie zwykle w warunku where - 1p
  - podzapytanie zwykle z podzapytaniem w klauzuli from - 0.5p
  - 2 podzapytania zwykle w warunku having  - 1p
  - 2 podzapytania skorelowane z podzapytaniem w klauzuli where  - 1p
  - 1 podzapytanie skorelowane z podzapytaniem w warunku having    - 1p
Wszystkie instrukcje Select  powinny zawierac tresc pytania uzasadniona biznesowo
 Projekt nalezy umiescic na szkolnym koncie w Oracle oraz w folderze Projekt na platformie edux*/





drop table rezyser CASCADE CONSTRAINTS;
drop table wytwornia CASCADE CONSTRAINTS;
drop table aktor CASCADE CONSTRAINTS;
drop table lokalizacja CASCADE CONSTRAINTS;
drop table gatunek CASCADE CONSTRAINTS;
drop table film CASCADE CONSTRAINTS;
drop table film_obsada CASCADE CONSTRAINTS;
drop table gatunek_film CASCADE CONSTRAINTS;
drop table rezerwacja CASCADE CONSTRAINTS;
drop table seans CASCADE CONSTRAINTS;


-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2018-06-13 08:48:21.091

-- tables
-- Table: aktor
CREATE TABLE aktor (
    imie_nazwisko varchar2(50)  NOT NULL,
    CONSTRAINT aktor_pk PRIMARY KEY (imie_nazwisko)
) ;

-- Table: film
CREATE TABLE film (
    tytul varchar2(30)  NOT NULL,
    rok integer  NOT NULL,
    rezyser_imie_nazwisko varchar2(50)  NOT NULL,
    wytwornia_nazwa varchar2(50)  NOT NULL,
    kraj_produkcji varchar2(30)  NOT NULL,
    ogr_wiekowe integer  NOT NULL,
    ocena float  NOT NULL,
    obejrzano integer  NOT NULL,
    opis varchar2(500)  NULL,
    CONSTRAINT film_pk PRIMARY KEY (tytul)
) ;

-- Table: film_obsada
CREATE TABLE film_obsada (
    film_tytul varchar2(30)  NOT NULL,
    aktor_imie_nazwisko varchar2(50)  NOT NULL,
    CONSTRAINT film_obsada_pk PRIMARY KEY (film_tytul,aktor_imie_nazwisko)
) ;

-- Table: gatunek
CREATE TABLE gatunek (
    nazwa varchar2(30)  NOT NULL,
    CONSTRAINT gatunek_pk PRIMARY KEY (nazwa)
) ;

-- Table: gatunek_film
CREATE TABLE gatunek_film (
    gatunek_nazwa varchar2(30)  NOT NULL,
    film_tytul varchar2(30)  NOT NULL
) ;

-- Table: lokalizacja
CREATE TABLE lokalizacja (
    centrum varchar2(30)  NOT NULL,
    miasto varchar2(30)  NOT NULL,
    CONSTRAINT lokalizacja_pk PRIMARY KEY (centrum,miasto)
) ;

-- Table: rezerwacja
CREATE TABLE rezerwacja (
    numer int  NOT NULL,
    rzad_miejsca int  NOT NULL,
    numer_miejsca int  NOT NULL,
    seans_IDseans int  NOT NULL,
    CONSTRAINT rezerwacja_pk PRIMARY KEY (numer,rzad_miejsca,numer_miejsca)
) ;

-- Table: rezyser
CREATE TABLE rezyser (
    imie_nazwisko varchar2(50)  NOT NULL,
    CONSTRAINT rezyser_pk PRIMARY KEY (imie_nazwisko)
) ;

-- Table: seans
CREATE TABLE seans (
    IDseans int  NOT NULL,
    film_tytul varchar2(30)  NOT NULL,
    data date  NOT NULL,
    godzina integer  NOT NULL,
    lokalizacja_miasto varchar2(30)  NOT NULL,
    lokalizacja_centrum varchar2(30)  NOT NULL,
    dubbing int  NOT NULL,
    nr_sali int  NOT NULL,
    CONSTRAINT seans_pk PRIMARY KEY (IDseans)
) ;

-- Table: wytwornia
CREATE TABLE wytwornia (
    nazwa varchar2(50)  NOT NULL,
    CONSTRAINT wytwornia_pk PRIMARY KEY (nazwa)
) ;

-- foreign keys
-- Reference: film_obsada_aktor (table: film_obsada)
ALTER TABLE film_obsada ADD CONSTRAINT film_obsada_aktor
    FOREIGN KEY (aktor_imie_nazwisko)
    REFERENCES aktor (imie_nazwisko);

-- Reference: film_obsada_film (table: film_obsada)
ALTER TABLE film_obsada ADD CONSTRAINT film_obsada_film
    FOREIGN KEY (film_tytul)
    REFERENCES film (tytul);

-- Reference: film_rezyser (table: film)
ALTER TABLE film ADD CONSTRAINT film_rezyser
    FOREIGN KEY (rezyser_imie_nazwisko)
    REFERENCES rezyser (imie_nazwisko);

-- Reference: film_wytwornia (table: film)
ALTER TABLE film ADD CONSTRAINT film_wytwornia
    FOREIGN KEY (wytwornia_nazwa)
    REFERENCES wytwornia (nazwa);

-- Reference: gatunek_film_film (table: gatunek_film)
ALTER TABLE gatunek_film ADD CONSTRAINT gatunek_film_film
    FOREIGN KEY (film_tytul)
    REFERENCES film (tytul);

-- Reference: gatunek_film_gatunek (table: gatunek_film)
ALTER TABLE gatunek_film ADD CONSTRAINT gatunek_film_gatunek
    FOREIGN KEY (gatunek_nazwa)
    REFERENCES gatunek (nazwa);

-- Reference: rezerwacja_seans (table: rezerwacja)
ALTER TABLE rezerwacja ADD CONSTRAINT rezerwacja_seans
    FOREIGN KEY (seans_IDseans)
    REFERENCES seans (IDseans);

-- Reference: seans_film (table: seans)
ALTER TABLE seans ADD CONSTRAINT seans_film
    FOREIGN KEY (film_tytul)
    REFERENCES film (tytul);

-- Reference: seans_lokalizacja (table: seans)
ALTER TABLE seans ADD CONSTRAINT seans_lokalizacja
    FOREIGN KEY (lokalizacja_miasto,lokalizacja_centrum)
    REFERENCES lokalizacja (miasto,centrum);



-- End of file.

-- Insert statements

INSERT INTO rezyser VALUES ('Christopher Nolan');
INSERT INTO rezyser VALUES ('Stephen Spielberg');
INSERT INTO rezyser VALUES ('Woody Allen');

INSERT INTO wytwornia VALUES ('Paramount Pictures');
INSERT INTO wytwornia VALUES ('Warner Brothers');
INSERT INTO wytwornia VALUES ('Legendary Pictures');
INSERT INTO wytwornia VALUES ('Mediapro');

INSERT INTO gatunek VALUES ('Komedia romantyczna');
INSERT INTO gatunek VALUES ('Thriller');
INSERT INTO gatunek VALUES ('Komedia');
INSERT INTO gatunek VALUES ('Dramat');
INSERT INTO gatunek VALUES ('Obyczajowy');
INSERT INTO gatunek VALUES ('Akcja');
INSERT INTO gatunek VALUES ('Psychologiczny');
INSERT INTO gatunek VALUES ('Przygodowy');

INSERT INTO film VALUES ('Batman: Mroczny Rycerz', 2012, 
  'Christopher Nolan', 'Legendary Pictures', 'USA', 12, 8.4, 256, NULL);
INSERT INTO film VALUES ('Vicky Christina Barcelona', 2008, 
  'Woody Allen', 'Mediapro', 'Hiszpania', 13, 7.1, 445, NULL);
INSERT INTO film VALUES ('Indiana Jones', 2009, 'Stephen Spielberg',
  'Warner Brothers', 'USA', 12, 7.6, 334, NULL);

INSERT INTO aktor VALUES ('Christian Bale');
INSERT INTO aktor VALUES ('Heath Ledger');
INSERT INTO aktor VALUES ('Penelope Cruz');
INSERT INTO aktor VALUES ('Scarlett Johansson');
INSERT INTO aktor VALUES ('Rebecca Hall');
INSERT INTO aktor VALUES ('Harrison Ford');
INSERT INTO aktor VALUES ('Cate Blanchett');

INSERT INTO film_obsada VALUES ('Batman: Mroczny Rycerz', 'Christian Bale');
INSERT INTO film_obsada VALUES ('Batman: Mroczny Rycerz', 'Heath Ledger');
INSERT INTO film_obsada VALUES ('Vicky Christina Barcelona', 'Penelope Cruz');
INSERT INTO film_obsada VALUES ('Vicky Christina Barcelona', 'Scarlett Johansson');
INSERT INTO film_obsada VALUES ('Vicky Christina Barcelona', 'Rebecca Hall');
INSERT INTO film_obsada VALUES ('Indiana Jones', 'Harrison Ford');
INSERT INTO film_obsada VALUES ('Indiana Jones', 'Cate Blanchett');
INSERT INTO film_obsada VALUES ('Indiana Jones', 'Scarlett Johansson');

INSERT INTO gatunek_film VALUES ('Akcja', 'Batman: Mroczny Rycerz');
INSERT INTO gatunek_film VALUES ('Thriller', 'Batman: Mroczny Rycerz');
INSERT INTO gatunek_film VALUES ('Komedia', 'Vicky Christina Barcelona');
INSERT INTO gatunek_film VALUES ('Komedia romantyczna', 'Vicky Christina Barcelona');
INSERT INTO gatunek_film VALUES ('Dramat', 'Vicky Christina Barcelona');
INSERT INTO gatunek_film VALUES ('Obyczajowy', 'Vicky Christina Barcelona');
INSERT INTO gatunek_film VALUES ('Akcja', 'Indiana Jones');
INSERT INTO gatunek_film VALUES ('Przygodowy', 'Indiana Jones');

INSERT INTO lokalizacja VALUES ('Bemowo', 'Warszawa');
INSERT INTO lokalizacja VALUES ('Centrum', 'Warszawa');
INSERT INTO lokalizacja VALUES ('Plaza', 'Krakow');

INSERT INTO seans VALUES (1, 'Batman: Mroczny Rycerz', TO_DATE('01-05-2018', 'DD-MM-YYYY'), 1200, 'Warszawa', 'Centrum', 0, 3);
INSERT INTO seans VALUES (2, 'Batman: Mroczny Rycerz', TO_DATE('01-05-2018', 'DD-MM-YYYY'), 1500, 'Warszawa', 'Centrum', 0, 3);
INSERT INTO seans VALUES (3, 'Batman: Mroczny Rycerz', TO_DATE('01-05-2018', 'DD-MM-YYYY'), 1300, 'Warszawa', 'Centrum', 0, 1);

COMMIT;

-- Moje zadania

--1. Podaj nazwy i rok produkcji wszystkich filmów z gatunku 'Akcja'
SELECT tytul, rok 
FROM gatunek_film INNER JOIN film ON film_tytul = tytul
WHERE gatunek_nazwa = 'Akcja';
--2. Podaj tytu³y i godziny filmów granych w Warszawie Centrum 1 maja 2018
--i których re¿yserem jest Christopher Nolan
SELECT film_tytul, godzina/100||':'||MOD(godzina, 100) godzina
FROM seans INNER JOIN film ON film_tytul = tytul
WHERE data = TO_DATE('01-05-2018', 'DD-MM-YYYY')
AND lokalizacja_miasto = 'Warszawa'
AND lokalizacja_centrum = 'Centrum'
AND rezyser_imie_nazwisko = 'Christopher Nolan';
--3. Podaj obsadê filmów z gatunku 'Akcja'
SELECT * FROM film_obsada obsada INNER JOIN gatunek_film gatunek 
    ON obsada.film_tytul = gatunek.film_tytul 
WHERE gatunek_nazwa = 'Akcja';

--4. Podaj ile filmow jakich gatunkow dostepnych w naszej sieci kin zostalo wyprodukowane w USA
SELECT gatunek_nazwa, COUNT(*)
FROM gatunek_film INNER JOIN film ON film_tytul = tytul
WHERE kraj_produkcji = 'USA'
GROUP BY gatunek_nazwa;

--5. Podaj ile miejsc jest zarezerwowane dla ktorego seansu. 
--Podaj tylko seanse dla których zarezerwowano wiecej niz 5 miejsc.
SELECT IDseans, COUNT (*)
FROM seans INNER JOIN rezerwacja ON seans_IDseans = IDseans
GROUP BY IDseans
HAVING COUNT (*) > 5;

--6. Jak w zadaniu 5, poka¿ tylko filmy po godzinie 15:00
SELECT IDseans, COUNT (*)
FROM seans INNER JOIN rezerwacja ON seans_IDseans = IDseans
WHERE godzina>1500
GROUP BY IDseans
HAVING COUNT (*) > 5;

--7. Podaj tytuly, rok produkcji i opisy wszystkich filmow, które nale¿± do tych samych gatunkow co Batman
SELECT tytul, rok, opis
FROM film INNER JOIN gatunek_film ON tytul = film_tytul 
WHERE gatunek_nazwa IN (SELECT gatunek_nazwa
	FROM gatunek_film
	WHERE film_tytul = 'Batman: Mroczny Rycerz');

--8. Podaj tytuly filmow, ktore sa grane w tej samej lokalizacji, co seans nr 1 i podaj co to za lokalizacja
SELECT UNIQUE film_tytul, lokalizacja_miasto, lokalizacja_centrum
FROM seans 
WHERE (lokalizacja_miasto, lokalizacja_centrum) = 
	(SELECT lokalizacja_miasto, lokalizacja_centrum
	FROM seans 
	WHERE IDseans = 1);

--9. Znajdz filmy o najwiekszej liczbie rezerwacji z kadego gatunku
SELECT tytul, gatunek_nazwa, rezerwacje
FROM (SELECT tytul, gatunek_nazwa, COUNT(*) AS rezerwacje
	FROM (film INNER JOIN gatunek_film ON film_tytul = tytul) f
	INNER JOIN (seans INNER JOIN rezerwacja 
	ON seans_IDseans = IDseans) s ON f.tytul = s.film_tytul
	GROUP BY gatunek_nazwa) tab
WHERE (gatunek_nazwa, rezerwacje) IN 
	(SELECT gatunek_nazwa, MAX(rezerwacje)
	FROM tab
	GROUP BY gatunek_nazwa);

--10. Wyswietl tyuly filmow, ktore maja wiecej rezerwacji niz 'Batman'
SELECT UNIQUE film_tytul , COUNT(*)
FROM seans INNER JOIN rezerwacja ON seans_IDseans = IDseans
GROUP BY film_tytul
HAVING COUNT(*) > (SELECT COUNT (*)
	FROM seans INNER JOIN rezerwacja ON seans_IDseans = IDseans
	WHERE film_tytul = 'Batman: Mroczny Rycerz');

--11. Wyswietl seansy 'Batmana', ktore maja wiecej rezerwacji niz seans o godzinie 12.00
SELECT IDseans, COUNT(*)
FROM seans INNER JOIN rezerwacja ON seans_IDseans = IDseans
WHERE film_tytul = 'Batman: Mroczny Rycerz'
GROUP BY IDseans 
HAVING COUNT(*) > (SELECT COUNT(*)
	FROM seans INNER JOIN rezerwacja ON seans_IDseans = IDseans
	WHERE film_tytul = 'Batman: Mroczny Rycerz'
	AND godzina = 1200);

--12. Znajdz seanse, na ktore nie zarezerwowano miejsc
SELECT IDseans FROM seans
WHERE NOT EXISTS (SELECT 1 FROM rezerwacja
	WHERE seans.IDseans = rezerwacja.seans_IDseans);

--13. Znajdz gatunki, ktore nie maja filmow
SELECT gatunek_nazwa
FROM gatunek-film
WHERE NOT EXISTS (SELECT 1 FROM film
		WHERE gatunek-film.film_tytul = film.tytul);

-- podzapytanie skorelowane z having
-- 14. Dla kazdego seansu znajdz seanse tego samego filmus ktore maja wieksza ilosc rezerwacji
SELECT IDseans, COUNT(*)
FROM (seans INNER JOIN rezerwacja ON seans_IDseans = IDseans) tab
GROUP BY IDseans 
HAVING COUNT(*) > (SELECT COUNT(*)
	FROM seans INNER JOIN rezerwacja ON seans_IDseans = IDseans
	WHERE film_tytul = tab.film_tytul);


--the end
