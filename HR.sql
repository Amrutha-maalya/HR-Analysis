CREATE DATABASE project;
USE project;
SELECT * FROM hr;
ALTER TABLE hr 
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

DESC hr;

SET sql_safe_updates=0;

UPDATE hr
SET birthdate = CASE
 WHEN birthdate LIKE'%/%'THEN date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
 WHEN birthdate LIKE'%-%'THEN date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
 ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

UPDATE hr
SET hire_date = CASE
 WHEN hire_date LIKE'%/%'THEN date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
 WHEN hire_date LIKE'%-%'THEN date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
 ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

UPDATE hr
SET termdate=CASE
 WHEN termdate IS NOT NULL AND termdate !='' THEN date(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC'))
 ELSE '0000-00-00'
END;

SET sql_mode='ALLOW_INVALID_DATES';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

SELECT termdate FROM hr;

ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr 
SET age= timestampdiff(YEAR,birthdate,CURDATE());

SELECT 
min(age) as youngest,
max(age) as oldest
FROM hr;

SELECT count(*) FROM hr WHERE age<18;

SELECT birthdate,age FROM hr;

