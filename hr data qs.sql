use project;
#QUESTIONS

#1.what is the gender beakdown of employees in the company?
SELECT gender,count(*) AS count
FROM hr
WHERE age>=18 AND termdate='0000-00-00'
GROUP BY gender;

#2.what is the race/ethncity breakdown of employees in the company?
SELECT race,count(*) AS count
FROM hr
WHERE age>=18 AND termdate='0000-00-00'
GROUP BY race
ORDER BY count(*) DESC;

#3.what is the age distribution of employees in the company?
SELECT min(age) AS youngest, max(age) AS oldest 
FROM hr
WHERE age>=18 AND termdate='0000-00-00';

SELECT 
  CASE
     WHEN age>=18 AND age<=24 THEN '18-24'
	 WHEN age>=25 AND age<=34 THEN '25-34'
	 WHEN age>=35 AND age<=44 THEN '35-44'
	 WHEN age>=45 AND age<=54 THEN '45-54'
	 WHEN age>=55 AND age<=64 THEN '55-64'
     ELSE '65+'
	END AS age_group,
    count(*) AS count
FROM hr
WHERE age>=18 AND termdate = '0000-00-00'
GROUP BY age_group
ORDER BY age_group;

SELECT 
  CASE
     WHEN age>=18 AND age<=24 THEN '18-24'
	 WHEN age>=25 AND age<=34 THEN '25-34'
	 WHEN age>=35 AND age<=44 THEN '35-44'
	 WHEN age>=45 AND age<=54 THEN '45-54'
	 WHEN age>=55 AND age<=64 THEN '55-64'
     ELSE '65+'
	END AS age_group,gender,
    count(*) AS count
FROM hr
WHERE age>=18 AND termdate = '0000-00-00'
GROUP BY age_group,gender
ORDER BY age_group,gender;

 #4.how many employees work at headquaters versus remote locations?
SELECT location,count(*) AS count FROM hr
WHERE age>=18 AND termdate='0000-00-00'
GROUP BY location;

#5.what is the average length of employment ofemployees who have been terminated?
SELECT round(avg(datediff(termdate,hire_date))/365,0) As avg_length_employment FROM hr
WHERE termdate<=curdate() AND termdate<>'0000-00-00' AND age>=18;

#6.How does the gender distribution vary across departments?
SELECT department,gender,count(*) AS count
FROM hr
WHERE age>=18 AND termdate='0000-00-00'
GROUP BY department,gender
ORDER BY department;

#7.what is the distribution of job titles across the company?
SELECT jobtitle,count(*) AS count
FROM hr
WHERE age>=18 AND termdate='0000-00-00'
GROUP BY jobtitle
ORDER BY jobtitle DESC;

#8.which department has highest turnover rate?
SELECT department,total_count,terminated_count,terminated_count/total_count AS termination_rate
FROM(
  SELECT department,count(*) AS total_count,
  SUM(CASE WHEN termdate<>'0000-00-00' AND termdate<=curdate() THEN 1 ELSE 0 END) AS terminated_count
  FROM hr
  WHERE age>=18
  GROUP BY department) AS subquery
  ORDER by termination_rate DESC;
  
  #9.what is the distribution of employees across locations by  state?
  SELECT location_state,count(*) AS count
  FROM hr
  WHERE age>=18 AND termdate='0000-00-00'
  GROUP BY location_state
  ORDER BY count DESC;