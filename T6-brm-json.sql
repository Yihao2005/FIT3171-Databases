/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T6-brm-json.sql

--Student ID: 35567082
--Student Name: Yihao Yu

/*
    -- Submission Declaration - must not be removed - removal will result in no marks being awarded --
    In submitting this SQL script, I confirm that this is my own work without coding assistance from Generative AI
*/

SET PAGESIZE 100
SET WRAP OFF
SET HEADING OFF

-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT 
    JSON_OBJECT ( '_id' VALUE c.cust_no,
                  'customer_name' VALUE c.cust_gname 
                  || ' '
                  || c.cust_fname,
                  'customer_business' VALUE NVL(c.cust_bname, '-'),
                  'customer_address' VALUE c.cust_street 
                  || ' '
                  || c.cust_town 
                  || ' '
                  || c.cust_pcode,
                  'customer_phone' VALUE c.cust_contact_no,
                  'customer_stats' VALUE JSON_OBJECT (
                        'number_of_quotes' VALUE COUNT(q.quote_no),
                        'number_of_jobs' VALUE COUNT(j.job_no),
                        'total_paid_jobcost' VALUE NVL(
                            (
                                SELECT TO_CHAR(SUM(NVL(j1.job_cost, q1.quote_cost)),'$9999990.00')
                                FROM quote q1 
                                JOIN job j1 ON q1.quote_no = j1.quote_no
                                WHERE q1.cust_no = c.cust_no
                                AND j1.job_payment_made = 'Y'
                            ),
                            '-'
                        ),
                        'total_unpaid_jobcost' VALUE NVL(
                            (
                                SELECT TO_CHAR(SUM(NVL(j2.job_cost, q2.quote_cost)),'$9999990.00')
                                FROM quote q2 
                                JOIN job j2 ON q2.quote_no = j2.quote_no
                                WHERE q2.cust_no = c.cust_no
                                AND j2.job_payment_made = 'N'
                            ),
                            '-'
                        )
                  ),
                  'quotes' VALUE JSON_ARRAYAGG(
                        JSON_OBJECT('quote_no' VALUE q.quote_no,
                                    'quote_prepared_on' VALUE TO_CHAR(q.quote_prepared_date, 'DD-Mon-YYYY'),
                                    'preferred_start_date' VALUE TO_CHAR(q.quote_pref_start_date, 'DD-Mon-YYYY'),
                                    'start_location' VALUE q.quote_start_location,
                                    'end_location' VALUE q.quote_end_location,
                                    'quote_cost' VALUE TO_CHAR(q.quote_cost, '$9999990.00'),
                                    'assigned_to_job' VALUE q.quote_job_status,
                                    'job_cost' VALUE NVL(
                                        TO_CHAR(NVL(j.job_cost, q.quote_cost), '$9999990.00'),
                                        '-'
                                    )
                        )
                        ORDER BY q.quote_no
                  )
                 

    FORMAT JSON)
    || ','
FROM 
    customer c 
    JOIN quote q ON q.cust_no = c.cust_no
    LEFT JOIN job j ON j.quote_no = q.quote_no
    GROUP BY 
        c.cust_no,
        c.cust_gname,
        c.cust_fname,
        c.cust_bname,
        c.cust_street,
        c.cust_town,
        c.cust_pcode,
        c.cust_contact_no
    ORDER BY c.cust_no;

    