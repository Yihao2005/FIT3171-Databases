--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T5-brm-plsql.sql

--Student ID: 35567082
--Student Name: Yihao Yu

/*
    -- Submission Declaration - must not be removed - removal will result in no marks being awarded --
    In submitting this SQL script, I confirm that this is my own work without coding assistance from Generative AI
*/

/* do not remove these set set serveroutput and set echo commands*/
SET SERVEROUTPUT ON
SET ECHO ON
/* end of do not remove*/


--(a)
-- Write your create function statemet,
-- finish it with a slash(/) followed by a blank line
CREATE OR REPLACE FUNCTION get_emp_role (i_emp_no IN NUMERIC)
    RETURN CHAR 
    IS o_emp_role CHAR(1);
    BEGIN 
        SELECT emp_role 
            INTO o_emp_role
        FROM employee 
        WHERE emp_no = i_emp_no;

        RETURN o_emp_role;
    END;
/

-- Write Test Harness for (a)
SELECT 
    emp_no,
    get_emp_role(emp_no) as emp_supposed_role
FROM employee 
ORDER BY emp_no;

SELECT 
    emp_no,
    emp_role 
FROM employee 
ORDER BY emp_no;


--(b)
-- Write your create trigger statement,
-- finish it with a slash(/) followed by a blank line
CREATE OR REPLACE TRIGGER check_employee_integrity BEFORE 
    INSERT ON employee FOR EACH ROW 
BEGIN 
    IF(:new.emp_role IS NULL) THEN 
        raise_application_error(-20000, 'employee must have at least one role');
    END IF;

    IF (:new.emp_role NOT IN ('B','T','D','M')) THEN 
        raise_application_error(-20001, 'employee role must be B, T, D or M');
    END IF;

    IF (:new.emp_role = 'B' AND :new.emp_no_manager IS NOT NULL) THEN 
        raise_application_error(-20002, 'manager could not be assigned to another manager');
    END IF;

    IF (:new.emp_role <> 'B' AND :new.emp_no_manager IS NULL)THEN 
        raise_application_error(-20003, 'non-manager employee must be assigned to a manager');
    END IF;

    IF (:new.emp_role <> 'B' AND get_emp_role(:new.emp_no_manager) <> 'B') THEN 
        raise_application_error(-20004, 'non-manager employee must be assigned to the employee whose role is manager');
    END IF;

    IF (:new.emp_role = 'D' AND :new.emp_licenceno IS NULL) THEN 
        raise_application_error(-20005, 'driver must have the licence number');
    END IF;

    IF (:new.emp_role <> 'D' AND :new.emp_licenceno IS NOT NULL) THEN 
        raise_application_error(-20006, 'non-driver must not have the licence number');
    END IF;
END;
/


-- Write Test Harness for (b)
-- before value
SELECT * FROM employee ORDER BY emp_no;

-- test trigger - insert employee with no employee role - failed
BEGIN 
    INSERT INTO employee VALUES (
        20,
        'Andy',
        'Apple',
        '0400000020',
        NULL,
        NULL,
        NULL
    );
    EXCEPTION 
        WHEN OTHERS THEN 
            dbms_output.put_line('Test passed: '|| SQLERRM);
END;
/
--after value
SELECT * FROM employee ORDER BY emp_no;
-- test trigger - insert employee with employee role but not in 'B', 'T', 'D' or 'M' - failed
BEGIN 
    INSERT INTO employee VALUES (
        21,
        'Buddy',
        'Buzzle',
        '0400000021',
        NULL,
        'A',
        NULL
    );
    EXCEPTION 
        WHEN OTHERS THEN 
            dbms_output.put_line('Test passed: '|| SQLERRM);
END;
/
--after value
SELECT * FROM employee ORDER BY emp_no;
-- test trigger - insert manager_emp_no for employee whose emp_role = 'B' -failed
BEGIN 
    INSERT INTO employee VALUES (
        22,
        'Cindy',
        'Catch',
        '0400000022',
        NULL,
        'B',
        1
    );
    EXCEPTION 
        WHEN OTHERS THEN 
            dbms_output.put_line('Test passed: '|| SQLERRM);
END;
/
--after value
SELECT * FROM employee ORDER BY emp_no;
-- test trigger - do not insert manager_emp_no for employee whose emp_role is not 'B' -failed
BEGIN 
    INSERT INTO employee VALUES (
        23,
        'Doge',
        'Dog',
        '0400000023',
        NULL,
        'T',
        NULL
    );
    EXCEPTION 
        WHEN OTHERS THEN 
            dbms_output.put_line('Test passed: '|| SQLERRM);
END;
/
--after value
SELECT * FROM employee ORDER BY emp_no;
-- test trigger -  insert non manager_emp_no for employee whose emp_role is not 'B' -failed
BEGIN 
    INSERT INTO employee VALUES (
        24,
        'Eve',
        'Eva',
        '0400000024',
        NULL,
        'T',
        4
    );
    EXCEPTION 
        WHEN OTHERS THEN 
            dbms_output.put_line('Test passed: '|| SQLERRM);
END;
/
--after value
SELECT * FROM employee ORDER BY emp_no;
-- test trigger -  do not insert emp_licenceno for employee whose emp_role is 'D' -failed
BEGIN 
    INSERT INTO employee VALUES (
        25,
        'File',
        'Fate',
        '0400000025',
        NULL,
        'D',
        2
    );
    EXCEPTION 
        WHEN OTHERS THEN 
            dbms_output.put_line('Test passed: '|| SQLERRM);
END;
/
--after value
SELECT * FROM employee ORDER BY emp_no;
-- test trigger -  insert emp_licenceno for employee whose emp_role is not 'D' -failed
BEGIN 
    INSERT INTO employee VALUES (
        26,
        'Gurry',
        'Golden',
        '0400000026',
        'DRV00000026',
        'B',
        NULL
    );
    EXCEPTION 
        WHEN OTHERS THEN 
            dbms_output.put_line('Test passed: '|| SQLERRM);
END;
/
--after value
SELECT * FROM employee ORDER BY emp_no;
-- test trigger -  insert valid driver -success
BEGIN 
    INSERT INTO employee VALUES (
        27,
        'Hello',
        'Hi',
        '0400000027',
        'DRV00000027',
        'D',
         2
    );
    dbms_output.put_line('Test passed');
    EXCEPTION 
        WHEN OTHERS THEN 
            dbms_output.put_line('Test failed: '|| SQLERRM);
END;
/
--after value
SELECT * FROM employee ORDER BY emp_no;
-- Close the transaction
ROLLBACK;
--End of the test Harness

--(c)
-- Complete the following create procedure statement
-- do not change the name and/or the order of the parameters
-- finish it with a slash(/) followed by a blank line

CREATE OR REPLACE PROCEDURE prc_entry_job(
p_quote_no IN NUMBER,
p_driver_no IN NUMBER,
p_dispatcher_no IN NUMBER,
p_truck_vin IN VARCHAR2,
p_trailer_code IN CHAR,
p_job_cost IN NUMBER,
p_job_payment IN CHAR,
p_job_pickup_dt IN DATE,
p_job_duration IN NUMBER,
p_output OUT VARCHAR2)
IS
    var_quote_found NUMBER;
    var_job_found NUMBER;
    var_combination_found NUMBER;
    var_quote_cost NUMBER;
BEGIN
    SELECT 
        COUNT(*) INTO var_quote_found
    FROM 
        quote 
    WHERE 
        quote_no = p_quote_no;

    IF var_quote_found = 0 THEN 
        p_output := 'Invalid quote number. The quote does not exist!';
    ELSE 
        SELECT 
            COUNT(*) INTO var_job_found 
        FROM 
            job
        WHERE 
            quote_no = p_quote_no;
        
        IF var_job_found > 0 THEN 
            p_output := 'Invalid quote number. The quote has already been assigned to a job!';
        
        ELSE
            IF get_emp_role(p_driver_no) IS NULL THEN 
            p_output := 'Invalid driver number. The driver does not exist!';

            ELSE 
                IF get_emp_role(p_driver_no) <> 'D' THEN 
                p_output := 'Invalid driver number. The employee is not a driver!';

                 ELSE
                    IF get_emp_role(p_dispatcher_no) IS NULL THEN 
                    p_output := 'Invalid dispatcher number. The dispatcher does not exist!';

                    ELSE 
                        IF get_emp_role(p_dispatcher_no) <> 'T' THEN 
                        p_output := 'Invalid dispatcher number. The employee is not a dispatcher!';

                        ELSE 
                            SELECT 
                                COUNT(*) INTO var_combination_found 
                            FROM 
                                combination
                            WHERE 
                                truck_vin = p_truck_vin 
                                AND trailer_code = p_trailer_code;

                            IF var_combination_found = 0 THEN 
                            p_output := 'Invalid truck vin and trailer code. The combination does not exist!';

                            ELSE 
                                SELECT 
                                    quote_cost INTO var_quote_cost 
                                FROM 
                                    quote 
                                WHERE 
                                    quote_no = p_quote_no ;

                                IF var_quote_cost = p_job_cost THEN 
                                p_output := 'Invalid job cost. The job cost is only recorded where the job cost if different from quote cost!';

                                ELSE 
                                    IF p_job_payment NOT IN ('Y','N') THEN 
                                    p_output := 'Invalid job payment. The payment status must be Y or N!';

                                    ELSE 
                                        IF p_job_duration <=0 THEN 
                                        p_output := 'Invalid job duration. The job duration must be greater than zero!';

                                        ELSE 
                                            INSERT INTO job VALUES(
                                                job_seq.NEXTVAL,
                                                p_job_pickup_dt,
                                                p_job_pickup_dt + p_job_duration/24,
                                                p_job_cost,
                                                p_job_payment,
                                                p_quote_no,
                                                p_dispatcher_no,
                                                p_driver_no,
                                                p_trailer_code,
                                                p_truck_vin
                                            );

                                            UPDATE quote 
                                            SET quote_job_status = 'Y'
                                            WHERE quote_no = p_quote_no;

                                            p_output := 'The new job for quote number '
                                                        || p_quote_no
                                                        || ' has been recorded';
                                            


                                        END IF;
                                    END IF;
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                END IF;
            END IF;
        END IF;
    END IF;
EXCEPTION 
    WHEN OTHERS THEN 
        p_output := SQLERRM;


END;
/

-- Write Test Harness for (c)
--before value 
SELECT * FROM job WHERE quote_no = 999;
--execute the procedure - invalid quote number(quote does not exist)
DECLARE 
    output VARCHAR(200);
BEGIN
    prc_entry_job(999, 6, 3, '1HGBH41JXMN109186', 'TRL01', 1000, 'Y', TO_DATE('28-May-2026 09:00', 'DD-Mon-YYYY HH24:MI'), 5, output);
    dbms_output.put_line('Invalid quote number test output: ' || output);
END;
/
--after value 
SELECT * FROM job WHERE quote_no = 999;

--before value
SELECT * FROM job WHERE quote_no = 1;
--execute the procedure - invalid quote number(quote has already been assigned)
DECLARE 
    output VARCHAR(200);
BEGIN
    prc_entry_job(1, 6, 3, '1HGBH41JXMN109186', 'TRL01', 1200, 'Y', TO_DATE('28-May-2026 09:00', 'DD-Mon-YYYY HH24:MI'), 5, output);
    dbms_output.put_line('Invalid quote number test output: ' || output);
END;
/
--after value 
SELECT * FROM job WHERE quote_no = 1;

--before value
SELECT * FROM job WHERE quote_no = 22;
--execute the procedure - invalid driver number. The driver does not exist!
DECLARE 
    output VARCHAR(200);
BEGIN
    prc_entry_job(22, 100, 4, '1HGBH41JXMN109186', 'TRL01', 1200, 'Y', TO_DATE('29-May-2026 09:00', 'DD-Mon-YYYY HH24:MI'), 5, output);
    dbms_output.put_line('Invalid driver number test output: ' || output);
END;
/
--after value 
SELECT * FROM job WHERE quote_no = 22;

--before value
SELECT * FROM job WHERE quote_no = 22;
--execute the procedure - invalid driver number. The employee is not a driver!
DECLARE 
    output VARCHAR(200);
BEGIN
    prc_entry_job(22, 3, 4, '1HGBH41JXMN109186', 'TRL01', 1200, 'Y', TO_DATE('29-May-2026 09:00', 'DD-Mon-YYYY HH24:MI'), 5, output);
    dbms_output.put_line('Invalid driver number test output: ' || output);
END;
/
--after value 
SELECT * FROM job WHERE quote_no = 22;


--before value
SELECT * FROM job WHERE quote_no = 22;
--execute the procedure - invalid dispatcher number.The dispatcher does not exist!
DECLARE 
    output VARCHAR(200);
BEGIN
    prc_entry_job(22, 6, 100, '1HGBH41JXMN109186', 'TRL01', 1200, 'Y', TO_DATE('29-May-2026 09:00', 'DD-Mon-YYYY HH24:MI'), 5, output);
    dbms_output.put_line('Invalid dispatcher number test output: ' || output);
END;
/
--after value 
SELECT * FROM job WHERE quote_no = 22;

--before value
SELECT * FROM job WHERE quote_no = 22;
--execute the procedure - invalid dispatcher number.The employee is not a dispatcher!
DECLARE 
    output VARCHAR(200);
BEGIN
    prc_entry_job(22, 6, 6, '1HGBH41JXMN109186', 'TRL01', 1200, 'Y', TO_DATE('29-May-2026 09:00', 'DD-Mon-YYYY HH24:MI'), 5, output);
    dbms_output.put_line('Invalid dispatcher number test output: ' || output);
END;
/
--after value 
SELECT * FROM job WHERE quote_no = 22;

--before value
SELECT * FROM job WHERE quote_no = 22;
--execute the procedure - invalid truck and trailer combination
DECLARE 
    output VARCHAR(200);
BEGIN
    prc_entry_job(22, 6, 3, '1HGBH41JXMN109186', 'TRL02', 1200, 'Y', TO_DATE('29-May-2026 09:00', 'DD-Mon-YYYY HH24:MI'), 5, output);
    dbms_output.put_line('Invalid combination test output: ' || output);
END;
/
--after value 
SELECT * FROM job WHERE quote_no = 22;

--before value
SELECT * FROM job WHERE quote_no = 22;
--execute the procedure - invalid job cost. The job cost is only recorded where the job cost if different from quote cost!
DECLARE 
    output VARCHAR(200);
BEGIN
    prc_entry_job(22, 6, 3, '1HGBH41JXMN109186', 'TRL01', 1500, 'Y', TO_DATE('29-May-2026 09:00', 'DD-Mon-YYYY HH24:MI'), 5, output);
    dbms_output.put_line('Invalid job cost test output: ' || output);
END;
/
--after value 
SELECT * FROM job WHERE quote_no = 22;

--before value
SELECT * FROM job WHERE quote_no = 22;
--execute the procedure - invalid job payment. The payment status must be Y or N!
DECLARE 
    output VARCHAR(200);
BEGIN
    prc_entry_job(22, 6, 3, '1HGBH41JXMN109186', 'TRL01', 1200, 'O', TO_DATE('29-May-2026 09:00', 'DD-Mon-YYYY HH24:MI'), 5, output);
    dbms_output.put_line('Invalid job payment test output: ' || output);
END;
/
--after value 
SELECT * FROM job WHERE quote_no = 22;

--before value
SELECT * FROM job WHERE quote_no = 22;
--execute the procedure - Invalid job duration. The job duration must be greater than zero!
DECLARE 
    output VARCHAR(200);
BEGIN
    prc_entry_job(22, 6, 3, '1HGBH41JXMN109186', 'TRL01', 1200, 'Y', TO_DATE('29-May-2026 09:00', 'DD-Mon-YYYY HH24:MI'), -1, output);
    dbms_output.put_line('Invalid job duration test output: ' || output);
END;
/
--after value 
SELECT * FROM job WHERE quote_no = 22;

--before value
SELECT * FROM job WHERE quote_no = 22;
--execute the procedure - success!
DECLARE 
    output VARCHAR(200);
BEGIN
    prc_entry_job(22, 6, 3, '1HGBH41JXMN109186', 'TRL01', 1200, 'Y', TO_DATE('29-May-2026 09:00', 'DD-Mon-YYYY HH24:MI'), 5, output);
    dbms_output.put_line('Success test output: ' || output);
END;
/
--after value 
SELECT * FROM job WHERE quote_no = 22;


--close the transaction
ROLLBACK;
-- End of Test Harness

/* do not add any further set serveroutput and set echo commands in this file */