CREATE TYPE dept_Type
/

CREATE TYPE employee_Type AS OBJECT (
    empno CHAR(6),
    firstName VARCHAR(12),
    lastName VARCHAR(15),
    workDept REF dept_Type,
    sex CHAR(1),
    birthDate Date,
    salary NUMBER(8, 2)
)
/

CREATE TYPE dept_Type AS OBJECT (
    deptNo CHAR(3),
    deptName VARCHAR(36),
    mgrNo REF employee_Type,
    admrDept REF dept_Type
)
/

-- CREATE Table
CREATE TABLE EMPLOYEE_TABLE OF employee_Type (
    CONSTRAINT tblemp_PK PRIMARY KEY (empno),
    CONSTRAINT tblemp_fname firstName NOT NULL,
    CONSTRAINT tblemp_lname lastName NOT NULL,
    CONSTRAINT tblemp_check_sex CHECK(sex = 'M' OR sex = 'm' OR sex = 'F' OR sex = 'f')
)
/

CREATE TABLE DEPARTMENT_TABLE OF dept_Type (
    CONSTRAINT tbldept_PK PRIMARY KEY (deptNo),
    CONSTRAINT tbldept_deptName deptName NOT NULL,
    CONSTRAINT tbldept_mgrNo_FK FOREIGN KEY (mgrNo) REFERENCES EMPLOYEE_TABLE,
    CONSTRAINT tbldept_admin_FK FOREIGN KEY (admrDept) REFERENCES DEPARTMENT_TABLE
)
/

-- Inset Values

INSERT INTO DEPARTMENT_TABLE VALUES (
    dept_Type('A00', 'SPIFFY', NULL, NULL)
)
/

INSERT INTO DEPARTMENT_TABLE VALUES (
    dept_Type('B01', 'Planning', NULL, (SELECT REF(d) FROM DEPARTMENT_TABLE d WHERE d.deptNo = 'A00'))
)
/

INSERT INTO DEPARTMENT_TABLE VALUES (
    dept_Type('C001', 'Information Centre', NULL, (SELECT REF(d) DEPARTMENT_TABLE d WHERE d.deptNo = 'A00'))
)
/

-- Updates
UPDATE DEPARTMENT_TABLE d
SET d.admrDept = (
    SELECT REF(d) 
    FROM DEPARTMENT_TABLE d
    WHERE d.deptNo = 'A00'
)
/

-- Complex Updates
UPDATE DEPARTMENT_TABLE d
SET d.mgrNo = (
    SELECT REF(d)
    FROM EMPLOYEE_TABLE e
    WHERE e.empno = '00010'
)
WHERE d.deptNo = 'A00'
/
