/* 
------------------------------------------------
/ / CREATE tables 
------------------------------------------------ 
*/


CREATE TABLE client(
    clno CHAR(3),
    name VARCHAR(12),
    address VARCHAR(30),
    PRIMARY KEY (clno)
) / 


CREATE TABLE stock(
    company CHAR(7),
    price NUMBER(6, 2),
    dividend NUMBER(4, 2),
    eps NUMBER(4, 2),
    PRIMARY KEY (company)
) / 


CREATE TABLE trading(
    company CHAR(7),
    exchange VARCHAR(12),
    PRIMARY KEY (company, exchange),
    FOREIGN KEY (company) REFERENCES stock(company)
) / 



CREATE TABLE purchase(
    clno CHAR(3),
    company CHAR(7),
    pdate DATE,
    qty NUMBER(6),
    price NUMBER(6, 2),
    PRIMARY KEY (clno, company, pdate),
    FOREIGN KEY (clno) REFERENCES client(clno),
    FOREIGN KEY (company) REFERENCES stock(company)
) /

/*
------------------------------------------------
/ / Inserting values for above tables
------------------------------------------------
*/

INSERT INTO client VALUES ('C01','John Smith','3 East Av Bentley WA 6102')
/

INSERT INTO client VALUES ('C02','Jill Brody','42 Bent St Perth WA 6001')
/


/* --------------------------------------*/

INSERT INTO stock VALUES ('BHP',10.50,1.50,3.20)
/
INSERT INTO stock VALUES ('IBM',70.00,4.25,10.00)
/
INSERT INTO stock VALUES ('INTEL',40.00,5.00,12.40)
/
INSERT INTO stock VALUES ('FORD',76.50,2.00,8.50)
/
INSERT INTO stock VALUES ('GM',60.00,2.50,9.20)
/
INSERT INTO stock VALUES ('INFOSYS',45.00,3.00,7.80)
/

/*--------------------------------------------------- */

INSERT INTO  trading VALUES ('BHP','Sydney')
/
INSERT INTO  trading VALUES ('BHP','New York')
/
INSERT INTO  trading VALUES ('IBM','New York')
/
INSERT INTO  trading VALUES ('IBM','London')
/
INSERT INTO  trading VALUES ('IBM','Tokyo')
/
INSERT INTO  trading VALUES ('INTEL','New York')
/
INSERT INTO  trading VALUES ('INTEL','London')
/
INSERT INTO  trading VALUES ('FORD','New York')
/
INSERT INTO  trading VALUES ('GM','New York')
/
INSERT INTO  trading VALUES ('INFOSYS','New York')
/

/*----------------------------------------------------*/

INSERT INTO purchase VALUES ('C01','BHP', DATE '2001-10-02',1000,12.00)
/
INSERT INTO purchase VALUES('C01','BHP', DATE '2002-06-08',2000,10.50)
/

INSERT INTO purchase VALUES('C01','IBM', DATE '2000-02-12',500,58.00)
/

INSERT INTO purchase VALUES('C01','IBM', DATE '2001-04-10',1200,65.00)
/

INSERT INTO purchase VALUES('C01','INFOSYS', DATE '2001-08-11',1000,64.00)
/

INSERT INTO purchase VALUES ('C02','INTEL', DATE '2000-01-30',300,35.00)
/

INSERT INTO purchase VALUES('C02','INTEL', DATE '2001-01-30',400,54.00)
/

INSERT INTO purchase VALUES('C02','INTEL', DATE '2001-10-02',200,60.00)
/

INSERT INTO purchase VALUES('C02','FORD', DATE '1999-10-05',300,40.00)
/

INSERT INTO purchase VALUES('C02','GM', DATE '2000-12-12',500,55.50)
/

/* -------------------------------------------------------------------------

/ / Querie Quections

------------------------------------------------------------------------- */

/*01.*/

SELECT DISTINCT c.name,s.company,s.price,s.dividend,s.eps
FROM client c , stock s ,purchase p
WHERE c.clno = p.clno AND s.company = p.company  
ORDER BY c.name
/

/*------------------------------------*/

/*02.*/
SELECT s.COMPANY,c.name, sum(p.qty)As total_number_of_shares, sum(p.qty*p.price)/sum(p.qty)AS Average_price_paid_by_the_client
FROM client c , purchase p ,stock s 
WHERE c.clno = p.clno AND s.COMPANY = p.COMPANY
GROUP BY c.name , p.COMPANY
ORDER BY p.COMPANY
/

/*--------------------------------------------*/

/*03*/

SELECT s.company , c.name, sum(p.qty*p.price) AS number_of_Sheres_held , sum(s.price*p.qty) AS current_value_of_shares
FROM client c, stock s, purchase p , trading t
WHERE c.clno = p.clno AND s.company = p.company AND p.company = t.company AND t.exchange = 'New York'
GROUP BY s.company , c.name
ORDER BY s.company
/

/*-----------------------------------------------------------------*/

/*04.*/

SELECT c.name , SUM(p.price*p.qty) AS total_purchase_value
FROM client c , purchase p
WHERE c.clno = p.clno
GROUP BY c.name
ORDER BY c.name
/

/*--------------------------------------------------*/

/*05*/

SELECT c.name , SUM(p.price*p.qty)-SUM(s.price*p.qty)AS book_profit
FROM client c , stock s , purchase p
WHERE c.clno = p.clno AND s.company = p.company
GROUP BY c.name
ORDER BY c.name
/

SELECT c.name, (SUM(s.price * p.qty) - SUM(p.qty * p.price)) 'Profit'
FROM client c, stock s, purchase p
WHERE c.clno = p.clno AND s.company = p.company
GROUP BY c.name
/