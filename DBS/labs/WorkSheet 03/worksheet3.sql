(1)

CREATE TYPE exchanges_varray as VARRAY(3)
  OF VARCHAR(40)
 /

CREATE TYPE stock_type AS OBJECT
 (
  companyName VARCHAR(20),
  currentPrice NUMBER(6,2),
  exchanges exchanges_varray,
  lastDivident NUMBER(4,2),
  eps NUMBER(4,2)
  )
/
 
CREATE TYPE address_type AS OBJECT
(
  streetNo char(10),
  streetName char(15),
  suburb char(20),
  state char(15),
  pin char(10)
)
/

CREATE TYPE Investment_type AS OBJECT
(
 company REF stock_type,
 purchasePrice NUMBER(6,2),
 purchaseDate DATE,
 quantity NUMBER(6)
)
/

CREATE TYPE investment_nestedtb_type AS TABLE OF Investment_type
/

CREATE TYPE client_type AS OBJECT(
   name Varchar(40),
   address address_type,
   investment investment_nestedtb_type
);


(2)

CREATE TABLE client of client_type(
   CONSTRAINT client_pk PRIMARY KEY(name)
   NESTED TABLE investment STORE AS investment_tab
)
/

CREATE TABLE stock of stock_type(
     CONSTRAINT stock_pk PRIMARY KEY(companyName)
)
/

ALTER TABLE investment_tab
ADD SCOPE FOR (company) IS stock
/

insert into client Values(client_type('John Smith',address_type('3','East Av','Bentley','WA','6102'),
investment_nestedtb_type(investment_type('BHP',12.00,'02-10-01',1000)))
/

insert into client Values(client_type('John Smith',address_type('3','East Av','Bentley','WA','6102'),
investment_nestedtb_type(investment_type('BHP',10.50,'08-06-02',2000)))
/

insert into client Values(client_type('John Smith',address_type('3','East Av','Bentley','WA','6102'),
investment_nestedtb_type(investment_type('IBM',58.00,'12-02-00',500)))
/

insert into client Values(client_type('John Smith',address_type('3','East Av','Bentley','WA','6102'),
investment_nestedtb_type(investment_type('IBM',65.00,'10-04-01',1200)))
/

insert into client Values(client_type('John Smith',address_type('3','East Av','Bentley','WA','6102'),
investment_nestedtb_type(investment_type('INFOSYS',64.00,'11-08-01',1000)))
/

insert into client Values(client_type('Jill Brody',address_type('42','Bent St','Perath','WA','6001'),
investment_nestedtb_type(investment_type('INTEL',35.00,'30-01-00',300)))
/

insert into client Values(client_type('Jill Brody',address_type('42','Bent St','Perath','WA','6001'),
investment_nestedtb_type(investment_type('INTEL',54.00,'30-01-01',400)))
/

insert into client Values(client_type('Jill Brody',address_type('42','Bent St','Perath','WA','6001'),
investment_nestedtb_type(investment_type('INTEL',60.00,'02-10-01',200)))
/

insert into client Values(client_type('Jill Brody',address_type('42','Bent St','Perath','WA','6001'),
investment_nestedtb_type(investment_type('FORD',40.00,'05-10-99',300)))
/

insert into client Values(client_type('Jill Brody',address_type('42','Bent St','Perath','WA','6001'),
investment_nestedtb_type(investment_type('GM',55.50,'12-12-00',500)))
/



insert into stock Values(stock_type('BHP',10.50,exchanges_varray('Sydney','New York'),1.50,3.20))
/

insert into stock Values(stock_type('IBM',70.00,exchanges_varray('New York','London','Tokyo'),4.25,10.00))
/
 
insert into stock Values(stock_type('INTEL',76.50,exchanges_varray('New York','London),5.00,12.40))

/
 
insert into stock Values(stock_type('FORD',40.00,exchanges_varray('New York'),2.00,8.50))
/
 
insert into stock Values(stock_type('INFOSYS',45.00,exchanges_varray('New York'),3.00,7.80))
/

(3)
(a)SELECT DISTINCT c.name,i.company,s.currentPrice,s.dividend,s.eps
   FROM client c,investment_tab i,stock s
   WHERE 


 
 