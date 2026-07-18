--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T4-brm-mods.sql

--Student ID: 35567082
--Student Name: Yihao Yu

/*
    -- Submission Declaration - must not be removed - removal will result in no marks being awarded --
    In submitting this SQL script, I confirm that this is my own work without coding assistance from Generative AI
*/

--4(a)

ALTER TABLE quote ADD (
    quote_job_status CHAR(1) DEFAULT 'N' NOT NULL,
    quote_not_converted_reason VARCHAR(100)
);

COMMENT ON COLUMN quote.quote_job_status IS 
    'The status which tells if the quote has been assigned to a job: Y-yes or N-no';

COMMENT ON COLUMN quote.quote_not_converted_reason IS 
    'The reason for not being converted to a job';

ALTER TABLE quote ADD CONSTRAINT ck_quote_job_status CHECK (quote_job_status IN ('Y', 'N'));

UPDATE quote 
SET quote_job_status = 'Y'
WHERE quote_no IN (
    SELECT quote_no 
    FROM job 
);

UPDATE quote 
SET quote_job_status = 'N'
WHERE quote_no NOT IN (
    SELECT quote_no 
    FROM job 
);

COMMIT;

SELECT * FROM quote ORDER BY quote_no;
DESC quote;


--4(b)

CREATE TABLE service (
    service_no NUMERIC(3) NOT NULL,
    service_start_date DATE NOT NULL,
    service_end_date DATE ,
    truck_vin CHAR(17) NOT NULL
);

COMMENT ON COLUMN service.service_no IS 
    'Service number for the service';

COMMENT ON COLUMN service.service_start_date IS 
    'The start date and time for the service';

COMMENT ON COLUMN service.service_end_date IS 
    'The end date and time for the service';

COMMENT ON COLUMN service.truck_vin IS 
    'The vin of car which gets service';
    
ALTER TABLE service ADD CONSTRAINT service_pk PRIMARY KEY (service_no);

ALTER TABLE service 
    ADD CONSTRAINT truck_service_fk FOREIGN KEY (truck_vin)
        REFERENCES truck(truck_vin);

ALTER TABLE service ADD CONSTRAINT ck_service_end_date 
    CHECK (service_end_date IS NULL OR service_end_date >= service_start_date);

CREATE TABLE task(
    task_no NUMERIC(3) NOT NULL,
    task_desc VARCHAR(100) NOT NULL
);

COMMENT ON COLUMN task.task_no IS 
    'The task number for the task';

COMMENT ON COLUMN task.task_desc IS 
    'The description for the task';

ALTER TABLE task ADD CONSTRAINT task_pk PRIMARY KEY (task_no);

CREATE TABLE service_task(
    service_no NUMERIC(3) NOT NULL,
    task_no NUMERIC(3) NOT NULL,
    emp_no NUMERIC(3) NOT NULL,
    service_task_note VARCHAR(200)
);

COMMENT ON COLUMN service_task.service_no IS 
    'The service number';

COMMENT ON COLUMN service_task.task_no IS 
    'The task number';

COMMENT ON COLUMN service_task.emp_no IS 
    'The number of the mechanic who does the task';

COMMENT ON COLUMN service_task.service_task_note IS 
    'Free text note (up to 200 characters) which explains the task';

ALTER TABLE service_task ADD CONSTRAINT service_task_pk PRIMARY KEY(service_no, task_no);

ALTER TABLE service_task 
    ADD CONSTRAINT task_service_task_fk FOREIGN KEY (task_no)
        REFERENCES task(task_no);

ALTER TABLE service_task
    ADD CONSTRAINT service_service_task_fk FOREIGN KEY (service_no)
        REFERENCES service(service_no);

ALTER TABLE service_task
    ADD CONSTRAINT employee_service_task_fk FOREIGN KEY (emp_no)
        REFERENCES employee(emp_no);

DESC service;
DESC task;
DESC service_task;