--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T3-brm-dm.sql

--Student ID: 35567082
--Student Name: Yihao Yu

/*
    -- Submission Declaration - must not be removed - removal will result in no marks being awarded --
    In submitting this SQL script, I confirm that this is my own work without coding assistance from Generative AI
*/

--3(a)
DROP SEQUENCE emp_seq;

CREATE SEQUENCE emp_seq START WITH 300 INCREMENT BY 5;

DROP SEQUENCE quote_seq;

CREATE SEQUENCE quote_seq START WITH 300 INCREMENT BY 5;

DROP SEQUENCE job_seq;

CREATE SEQUENCE job_seq START WITH 300 INCREMENT BY 5;

--3(b)
INSERT INTO employee VALUES(
    emp_seq.NEXTVAL,
    'Aurello',
    'Brown',
    '0431952053',
    NULL,
    'T',
    (
        SELECT emp_no
        FROM employee
        WHERE emp_gname = 'Sarah'
        AND emp_fname = 'Mitchell'
        AND emp_role = 'B'
    )
);

COMMIT;

--3(c)
INSERT INTO quote VALUES(
    quote_seq.NEXTVAL,
    TO_DATE('17-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('25-May-2026', 'DD-Mon-YYYY'),
    '29 Kuranda Road, Adelaide SA 5030',
    '9 Albatros Drive, Mount Gambier SA 5270',
    1000.00,
    (
        SELECT cust_no 
        FROM customer 
        WHERE UPPER(cust_gname) = 'VICTORIA'
        AND UPPER(cust_fname) = 'ELLA'
        AND cust_bname = 'Flintstone Store'
    ),
    (
        SELECT emp_no 
        FROM employee 
        WHERE emp_gname = 'Aurello'
        AND emp_fname = 'Brown'
        AND emp_role = 'T'
    )
);

INSERT INTO job VALUES(
    job_seq.NEXTVAL,
    TO_DATE('25-May-2026 09:00', 'DD-Mon-YYYY HH24:MI'),
    TO_DATE('25-May-2026 09:00', 'DD-Mon-YYYY HH24:MI') + 5/24,
    NULL,
    'Y',
    quote_seq.CURRVAL,
    (
        SELECT emp_no 
        FROM employee 
        WHERE emp_gname = 'Aurello'
        AND emp_fname = 'Brown'
        AND emp_role = 'T'
    ),
    (
        SELECT emp_no 
        FROM employee 
        WHERE emp_gname = 'Michael'
        AND emp_fname = 'Johnson'
        AND emp_role = 'D'
    ),
    'TRL08',
    '1HGBH41JXMN109186'
);

COMMIT;




--3(d)
UPDATE job j
SET 
    j.job_pickup_dt = TO_DATE('25-May-2026 14:00','DD-Mon-YYYY HH24:MI'),
    j.job_intended_dropoff_dt = TO_DATE('25-May-2026 14:00','DD-Mon-YYYY HH24:MI') + 5/24,
    j.job_cost = (
        SELECT q.quote_cost * 1.2 
        FROM quote q
        JOIN customer c ON q.cust_no = c.cust_no 
        WHERE UPPER(c.cust_gname) = 'VICTORIA'
        AND UPPER(c.cust_fname) = 'ELLA'
        AND c.cust_bname = 'Flintstone Store'
        AND q.quote_prepared_date = TO_DATE('17-May-2026', 'DD-Mon-YYYY')
    ),
    j.job_payment_made = 'Y'
WHERE j.quote_no = (
    SELECT q.quote_no 
    FROM quote q 
    JOIN customer c ON q.cust_no = c.cust_no 
    WHERE UPPER(c.cust_gname) = 'VICTORIA'
    AND UPPER(c.cust_fname) = 'ELLA'
    AND c.cust_bname = 'Flintstone Store'
    AND q.quote_prepared_date = TO_DATE('17-May-2026', 'DD-Mon-YYYY')
);

COMMIT;

--3(e)
DELETE FROM job j 
WHERE j.quote_no = (
    SELECT q.quote_no 
    FROM quote q
    JOIN customer c ON q.cust_no = c.cust_no 
    WHERE UPPER(c.cust_gname) = 'VICTORIA'
    AND UPPER(c.cust_fname) = 'ELLA'
    AND c.cust_bname = 'Flintstone Store'
    AND q.quote_prepared_date = TO_DATE('17-May-2026', 'DD-Mon-YYYY')
);

COMMIT;