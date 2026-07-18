/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T2-brm-insert.sql

--Student ID: 35567082
--Student Name: Yihao Yu

/*
Indicate if AI was used (Yes/No): Yes

If AI was used:
I used <<ChatGPT>>
I used these prompts: 

Generate Oracle SQL INSERT statements for the QUOTE and JOB
tables. The data must include at least 30 quotes and 20 jobs. It must include at least
5 customers and 2 dispatchers in quotes; at least 10 truck/trailer combinations in jobs;
at least 5 combinations used in at least 2 jobs; at least 2 quotes not assigned to jobs;
at least 5 jobs with a different cost from the quote;
and at least 5 jobs with the same cost as the quote. 
All numeric primary keys must be hardcoded below 100, all dates must be between 1 May 2026 and 31 July 2026,
and all dates must use TO_DATE.

I reviewed and modified the generated data before including it in this script
I acknowledge the use of [1]ChatGPT[2](https://chat.openai.com) to [3] generate the data that were included in this file.
*/

--------------------------------------
--INSERT INTO employee
--------------------------------------
INSERT INTO employee VALUES (   
    1,
    'Sarah',
    'Mitchell',
    '0400000001',
    NULL,
    'B',
    NULL
);

INSERT INTO employee VALUES (
    2,
    'Bob',
    'Bowl',
    '0400000002',
    NULL,
    'B',
    NULL
);

INSERT INTO employee VALUES (
    3,
    'Cathy',
    'Cat',
    '0400000003',
    NULL,
    'T',
    1
);

INSERT INTO employee VALUES (
    4,
    'Daisy',
    'Duck',
    '0400000004',
    NULL,
    'T',
    1

);

INSERT INTO employee VALUES (
    5,
    'Ellie',
    'Enthe',
    '0400000005',
    NULL,
    'M',
    2
);

INSERT INTO employee VALUES (
    6,
    'Michael',
    'Johnson',
    '0400000006',
    'DRV00000001',
    'D',
    1
);

INSERT INTO employee VALUES (
    7,
    'Gady',
    'Garlic',
    '0400000007',
    'DRV00000002',
    'D',
    1
);

INSERT INTO employee VALUES (
    8,
    'Harry',
    'Hazy',
    '0400000008',
    'DRV00000003',
    'D',
    2
);

INSERT INTO employee VALUES (
    9,
    'Idle',
    'Idea',
    '0400000009',
    'DRV00000004',
    'D',
    2
);

INSERT INTO employee VALUES (
    10,
    'Jack',
    'Jelly',
    '0400000010',
    NULL,
    'T',
    2
);


--------------------------------------
--INSERT INTO quote
--------------------------------------
INSERT INTO quote VALUES (
    1,
    TO_DATE('02-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('08-May-2026', 'DD-Mon-YYYY'),
    '55 Lonsdale Street, VIC 3008',
    '101 Pitt Street, NSW 2010',
    1200.00,
    1,
    3
);

INSERT INTO quote VALUES (
    2,
    TO_DATE('03-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('09-May-2026', 'DD-Mon-YYYY'),
    '55 Bourke Street, VIC 3001',
    '45 Rundle Street, SA 5006',
    950.00,
    4,
    4
);

INSERT INTO quote VALUES (
    3,
    TO_DATE('04-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('10-May-2026', 'DD-Mon-YYYY'),
    '42 Collins Street, VIC 3000',
    '78 Hay Street, WA 6003',
    1800.00,
    8,
    3
);

INSERT INTO quote VALUES (
    4,
    TO_DATE('05-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('11-May-2026', 'DD-Mon-YYYY'),
    '18 Chapel Street, VIC 3004',
    '15 George Street, NSW 2000',
    1100.00,
    17,
    10
);

INSERT INTO quote VALUES (
    5,
    TO_DATE('06-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('12-May-2026', 'DD-Mon-YYYY'),
    '15 George Street, NSW 2000',
    '61 Ann Street, QLD 4101',
    1350.00,
    2,
    4
);

INSERT INTO quote VALUES (
    6,
    TO_DATE('07-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('13-May-2026', 'DD-Mon-YYYY'),
    '23 Murray Street, WA 6000',
    '67 King William Street, SA 5000',
    1600.00,
    3,
    3
);

INSERT INTO quote VALUES (
    7,
    TO_DATE('08-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('14-May-2026', 'DD-Mon-YYYY'),
    '61 Ann Street, QLD 4101',
    '92 Oxford Street, NSW 2060',
    1400.00,
    5,
    10
);

INSERT INTO quote VALUES (
    8,
    TO_DATE('09-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('15-May-2026', 'DD-Mon-YYYY'),
    '29 Barrack Street, WA 6009',
    '34 Adelaide Street, QLD 4006',
    1550.00,
    6,
    4
);

INSERT INTO quote VALUES (
    9,
    TO_DATE('10-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('16-May-2026', 'DD-Mon-YYYY'),
    '72 Cavill Avenue, QLD 4217',
    '127 Parramatta Road, NSW 2150',
    1250.00,
    7,
    3
);

INSERT INTO quote VALUES (
    10,
    TO_DATE('11-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('17-May-2026', 'DD-Mon-YYYY'),
    '67 King William Street, SA 5000',
    '55 Lonsdale Street, VIC 3008',
    1000.00,
    9,
    10
);

INSERT INTO quote VALUES (
    11,
    TO_DATE('12-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('18-May-2026', 'DD-Mon-YYYY'),
    '45 Rundle Mall, SA 5006',
    '23 Murray Street, WA 6000',
    1750.00,
    10,
    3
);

INSERT INTO quote VALUES (
    12,
    TO_DATE('13-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('19-May-2026', 'DD-Mon-YYYY'),
    '38 Wellington Street, WA 6107',
    '72 Cavill Avenue, QLD 4217',
    1650.00,
    12,
    4
);

INSERT INTO quote VALUES (
    13,
    TO_DATE('14-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('20-May-2026', 'DD-Mon-YYYY'),
    '88 Queen Street, QLD 4000',
    '101 Pitt Street, NSW 2010',
    1450.00,
    13,
    10
);

INSERT INTO quote VALUES (
    14,
    TO_DATE('15-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('21-May-2026', 'DD-Mon-YYYY'),
    '101 Pitt Street, NSW 2010',
    '45 Rundle Mall, SA 5006',
    1150.00,
    14,
    3
);

INSERT INTO quote VALUES (
    15,
    TO_DATE('16-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('22-May-2026', 'DD-Mon-YYYY'),
    '78 Hay Street, WA 6003',
    '42 Collins Street, VIC 3000',
    1850.00,
    15,
    4
);

INSERT INTO quote VALUES (
    16,
    TO_DATE('17-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('23-May-2026', 'DD-Mon-YYYY'),
    '92 Oxford Street, NSW 2060',
    '18 Chapel Street, VIC 3004',
    1050.00,
    16,
    10
);

INSERT INTO quote VALUES (
    17,
    TO_DATE('18-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('24-May-2026', 'DD-Mon-YYYY'),
    '18 Chapel Street, VIC 3004',
    '67 King William Street, SA 5000',
    1300.00,
    17,
    3
);

INSERT INTO quote VALUES (
    18,
    TO_DATE('19-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('25-May-2026', 'DD-Mon-YYYY'),
    '94 Henley Beach Road, SA 5095',
    '9 Albatros Drive, SA 5270',
    1000.00,
    18,
    4
);

INSERT INTO quote VALUES (
    19,
    TO_DATE('20-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('26-May-2026', 'DD-Mon-YYYY'),
    '83 Jetty Road, SA 5063',
    '55 Lonsdale Street, VIC 3008',
    1250.00,
    19,
    10
);

INSERT INTO quote VALUES (
    20,
    TO_DATE('21-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('27-May-2026', 'DD-Mon-YYYY'),
    '127 Parramatta Road, NSW 2150',
    '61 Ann Street, QLD 4101',
    1350.00,
    20,
    3
);

INSERT INTO quote VALUES (
    21,
    TO_DATE('22-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('28-May-2026', 'DD-Mon-YYYY'),
    '55 Lonsdale Street, VIC 3008',
    '23 Murray Street, WA 6000',
    1900.00,
    1,
    4
);

INSERT INTO quote VALUES (
    22,
    TO_DATE('23-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('29-May-2026', 'DD-Mon-YYYY'),
    '56 Bourke Street, VIC 3001',
    '72 Cavill Avenue, QLD 4217',
    1500.00,
    4,
    10
);

INSERT INTO quote VALUES (
    23,
    TO_DATE('24-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('30-May-2026', 'DD-Mon-YYYY'),
    '42 Collins Street, VIC 3000',
    '67 King William Street, SA 5000',
    1700.00,
    8,
    3
);

INSERT INTO quote VALUES (
    24,
    TO_DATE('25-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('31-May-2026', 'DD-Mon-YYYY'),
    '18 Chapel Street, VIC 3004',
    '38 Wellington Street, WA 6107',
    2000.00,
    17,
    4
);

INSERT INTO quote VALUES (
    25,
    TO_DATE('26-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('01-Jun-2026', 'DD-Mon-YYYY'),
    '15 George Street, NSW 2000',
    '94 Henley Beach Road, SA 5095',
    1100.00,
    2,
    10
);

INSERT INTO quote VALUES (
    26,
    TO_DATE('27-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('02-Jun-2026', 'DD-Mon-YYYY'),
    '23 Murray Street, WA 6000',
    '127 Parramatta Road, NSW 2150',
    1950.00,
    3,
    3
);

INSERT INTO quote VALUES (
    27,
    TO_DATE('28-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('03-Jun-2026', 'DD-Mon-YYYY'),
    '61 Ann Street, QLD 4101',
    '45 Rundle Mall, SA 5006',
    1420.00,
    5,
    4
);

INSERT INTO quote VALUES (
    28,
    TO_DATE('29-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('04-Jun-2026', 'DD-Mon-YYYY'),
    '29 Barrack Street, WA 6009',
    '88 Queen Street, QLD 4000',
    1320.00,
    6,
    10
);

INSERT INTO quote VALUES (
    29,
    TO_DATE('30-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('05-Jun-2026', 'DD-Mon-YYYY'),
    '72 Cavill Avenue, QLD 4217',
    '56 Bourke Street, VIC 3001',
    1280.00,
    7,
    3
);

INSERT INTO quote VALUES (
    30,
    TO_DATE('31-May-2026', 'DD-Mon-YYYY'),
    TO_DATE('06-Jun-2026', 'DD-Mon-YYYY'),
    '67 King William Street, SA 5000',
    '78 Hay Street, WA 6003',
    1720.00,
    9,
    4
);


--------------------------------------
--INSERT INTO job
--------------------------------------
INSERT INTO job VALUES (
    1,
    TO_DATE('08-May-2026 09:00', 'DD-Mon-YYYY HH24:MI'),
    TO_DATE('08-May-2026 15:00', 'DD-Mon-YYYY HH24:MI'),
    NULL,
    'Y',
    1,
    3,
    6,
    'TRL01',
    '1HGBH41JXMN109186'
);

INSERT INTO job VALUES (
    2,
    TO_DATE('09-May-2026 10:00', 'DD-Mon-YYYY HH24:MI'),
    TO_DATE('09-May-2026 16:00', 'DD-Mon-YYYY HH24:MI'),
    NULL,
    'N',
    2,
    4,
    7,
    'TRL02',
    '2FMDK3GC8BBA12345'
);

INSERT INTO job VALUES (
    3,
    TO_DATE('10-May-2026 08:30', 'DD-Mon-YYYY HH24:MI'),
    TO_DATE('10-May-2026 18:30', 'DD-Mon-YYYY HH24:MI'),
    NULL,
    'Y',
    3,
    3,
    8,
    'TRL03',
    '3VWFE21C04M000001'
);

INSERT INTO job VALUES (
    4,
    TO_DATE('11-May-2026 11:00', 'DD-Mon-YYYY HH24:MI'),
    TO_DATE('11-May-2026 17:00', 'DD-Mon-YYYY HH24:MI'),
    NULL,
    'Y',
    4,
    10,
    9,
    'TRL04',
    '4T1BF1FK5CU123456'
);

INSERT INTO job VALUES (
    5,
    TO_DATE('12-May-2026 09:30', 'DD-Mon-YYYY HH24:MI'),
    TO_DATE('12-May-2026 16:30', 'DD-Mon-YYYY HH24:MI'),
    NULL,
    'N',
    5,
    4,
    6,
    'TRL05',
    '5FNRL5H40BB098765'
);

INSERT INTO job VALUES (
    6,
    TO_DATE('13-May-2026 07:30', 'DD-Mon-YYYY HH24:MI'),
    TO_DATE('13-May-2026 17:30', 'DD-Mon-YYYY HH24:MI'),
    NULL,
    'Y',
    6,
    3,
    7,
    'TRL06',
    '1FTFW1ET5DFC10112'
);

INSERT INTO job VALUES (
    7,
    TO_DATE('14-May-2026 08:00', 'DD-Mon-YYYY HH24:MI'),
    TO_DATE('14-May-2026 15:00', 'DD-Mon-YYYY HH24:MI'),
    NULL,
    'Y',
    7,
    10,
    8,
    'TRL07',
    '2C4RDGCG8ER123789'
);

INSERT INTO job VALUES (
    8,
    TO_DATE('15-May-2026 12:00', 'DD-Mon-YYYY HH24:MI'),
    TO_DATE('15-May-2026 19:00', 'DD-Mon-YYYY HH24:MI'),
    NULL,
    'N',
    8,
    4,
    9,
    'TRL08',
    '5XYKT3A69CG234567'
);

INSERT INTO job VALUES (
    9,
    TO_DATE('16-May-2026 09:00', 'DD-Mon-YYYY HH24:MI'),
    TO_DATE('16-May-2026 15:00', 'DD-Mon-YYYY HH24:MI'),
    NULL,
    'Y',
    9,
    3,
    6,
    'TRL05',
    '1HGBH41JXMN109186'
);

INSERT INTO job VALUES (
    10,
    TO_DATE('17-May-2026 10:30', 'DD-Mon-YYYY HH24:MI'),
    TO_DATE('17-May-2026 17:30', 'DD-Mon-YYYY HH24:MI'),
    NULL,
    'Y',
    10,
    10,
    7,
    'TRL08',
    '2FMDK3GC8BBA12345'
);

INSERT INTO job VALUES (
    11,
    TO_DATE('18-May-2026 08:00', 'DD-Mon-YYYY HH24:MI'),
    TO_DATE('18-May-2026 18:00', 'DD-Mon-YYYY HH24:MI'),
    1690.00,
    'N',
    11,
    3,
    8,
    'TRL01',
    '1HGBH41JXMN109186'
);

INSERT INTO job VALUES (
    12,
    TO_DATE('19-May-2026 09:00', 'DD-Mon-YYYY HH24:MI'),
    TO_DATE('19-May-2026 18:00', 'DD-Mon-YYYY HH24:MI'),
    1715.00,
    'Y',
    12,
    4,
    9,
    'TRL02',
    '2FMDK3GC8BBA12345'
);

INSERT INTO job VALUES (
    13,
    TO_DATE('20-May-2026 07:00', 'DD-Mon-YYYY HH24:MI'),
    TO_DATE('20-May-2026 14:00', 'DD-Mon-YYYY HH24:MI'),
    1500.00,
    'Y',
    13,
    10,
    6,
    'TRL03',
    '3VWFE21C04M000001'
);

INSERT INTO job VALUES (
    14,
    TO_DATE('21-May-2026 08:30', 'DD-Mon-YYYY HH24:MI'),
    TO_DATE('21-May-2026 14:30', 'DD-Mon-YYYY HH24:MI'),
    1090.00,
    'N',
    14,
    3,
    7,
    'TRL04',
    '4T1BF1FK5CU123456'
);

INSERT INTO job VALUES (
    15,
    TO_DATE('22-May-2026 09:30', 'DD-Mon-YYYY HH24:MI'),
    TO_DATE('22-May-2026 19:30', 'DD-Mon-YYYY HH24:MI'),
    1920.00,
    'Y',
    15,
    4,
    8,
    'TRL05',
    '5FNRL5H40BB098765'
);

INSERT INTO job VALUES (
    16,
    TO_DATE('23-May-2026 11:00', 'DD-Mon-YYYY HH24:MI'),
    TO_DATE('23-May-2026 17:00', 'DD-Mon-YYYY HH24:MI'),
    1120.00,
    'Y',
    16,
    10,
    9,
    'TRL06',
    '1FTFW1ET5DFC10112'
);

INSERT INTO job VALUES (
    17,
    TO_DATE('24-May-2026 08:00', 'DD-Mon-YYYY HH24:MI'),
    TO_DATE('24-May-2026 15:00', 'DD-Mon-YYYY HH24:MI'),
    1380.00,
    'N',
    17,
    3,
    6,
    'TRL07',
    '2C4RDGCG8ER123789'
);

INSERT INTO job VALUES (
    18,
    TO_DATE('25-May-2026 09:00', 'DD-Mon-YYYY HH24:MI'),
    TO_DATE('25-May-2026 14:00', 'DD-Mon-YYYY HH24:MI'),
    1080.00,
    'Y',
    18,
    4,
    7,
    'TRL08',
    '5XYKT3A69CG234567'
);

INSERT INTO job VALUES (
    19,
    TO_DATE('26-May-2026 10:00', 'DD-Mon-YYYY HH24:MI'),
    TO_DATE('26-May-2026 16:00', 'DD-Mon-YYYY HH24:MI'),
    1320.00,
    'N',
    19,
    10,
    8,
    'TRL05',
    '1HGBH41JXMN109186'
);

INSERT INTO job VALUES (
    20,
    TO_DATE('27-May-2026 08:30', 'DD-Mon-YYYY HH24:MI'),
    TO_DATE('27-May-2026 15:30', 'DD-Mon-YYYY HH24:MI'),
    1425.00,
    'Y',
    20,
    3,
    9,
    'TRL08',
    '2FMDK3GC8BBA12345'
);

COMMIT;

