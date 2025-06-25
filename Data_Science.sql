select * from salaries;
-- 1. As a market researcher, your job is to Investigate the job market for a company that analyzes workforce data. 
-- Your Task is to know how many people were employed IN different types of companies AS per their size IN 2021.
select 
	company_size, 
	COUNT(company_size) as "people_employed" 
from salaries 
where work_year=2021
group by 1
order by 2 desc;

/*2.Imagine you are a talent Acquisition specialist Working for an International recruitment agency. 
Your Task is to identify the top 3 job titles that command the highest average salary Among part-time Positions IN the year 2023.*/
select 
	job_title, ROUND(AVG(salary_in_usd),2) as "avg_salary" 
from salaries
where work_year=2023 AND employment_type="PT"
group by 1
order by 2 desc
limit 3;

/*3.As a database analyst you have been assigned the task to Select Countries where average mid-level salary 
is higher than overall mid-level salary for the year 2023.*/


select 
	company_location,ROUND(AVG(salary_in_usd),2) as "avg_salary" 
from salaries
where work_year=2023 and experience_level="MI"
group by 1
having AVG(salary_in_usd)> (
select 
	avg(salary_in_usd) as "overall_salary" 
from salaries 
where work_year=2023 and experience_level="MI");

/*4.As a database analyst you have been assigned the task to Identify the company locations with the highest and lowest average salary for 
senior-level (SE) employees in 2023.*/
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetSeniorSalaryStats`()
BEGIN
	DELIMITER //
    -- Query to find the highest average salary for senior-level employees in 2023
    SELECT highest_location, highest_avg_salary, lowest_location, lowest_avg_salary FROM (SELECT company_location AS highest_location, AVG(salary_in_usd) AS highest_avg_salary
    FROM  salaries
    WHERE work_year = 2023 AND experience_level = 'SE'
    GROUP BY company_location
    ORDER BY highest_avg_salary DESC
    LIMIT 1) AS t1
	CROSS JOIN
    (SELECT company_location AS lowest_location, AVG(salary_in_usd) AS lowest_avg_salary
    FROM  salaries
    WHERE work_year = 2023 AND experience_level = 'SE'
    GROUP BY company_location
    ORDER BY lowest_avg_salary ASC
    LIMIT 1) AS t2

END;
DELIMITER //
call GetSeniorSalaryStats;

/*5. You're a Financial analyst Working for a leading HR Consultancy, and your Task is to Assess the annual salary growth rate for various job titles. 
By Calculating the percentage Increase IN salary FROM previous year to this year, 
you aim to provide valuable Insights Into salary trends WITHIN different job roles.*/


with cte as (
select job_title,
	avg(case when work_year=2020 then salary_in_usd end) as "2020_y",
    avg(case when work_year=2021 then salary_in_usd end) as "2021_y",
    avg(case when work_year=2022 then salary_in_usd end) as "2022_y",
    avg(case when work_year=2023 then salary_in_usd end) as "2023_y",
    avg(case when work_year=2024 then salary_in_usd end) as "2024_y"
    from salaries
group by 1  )  

select job_title,
	round((2021_y-2020_y)/2020_y,2)*100 as "%_rate_2021",
    round((2022_y-2021_y)/2021_y,2)*100 as "%_rate_2022",
    round((2023_y-2022_y)/2022_y,2)*100 as "%_rate_2023",
    round((2024_y-2023_y)/2023_y,2)*100 as "%_rate_2024"
from cte;

/*6. You've been hired by a global HR Consultancy to identify Countries experiencing significant salary growth for entry-level roles.
 Your task is to list the top three Countries with the highest salary growth rate FROM 2020 to 2023, 
 helping multinational Corporations identify  Emerging talent markets.*/
 
 with cte as (
select company_location,
	avg(case when work_year=2020 then salary_in_usd end) as "2020_y",
    avg(case when work_year=2021 then salary_in_usd end) as "2021_y",
    avg(case when work_year=2022 then salary_in_usd end) as "2022_y",
    avg(case when work_year=2023 then salary_in_usd end) as "2023_y"
from salaries
where experience_level="EN"
group by 1  )  

select company_location,
	round((2021_y-2020_y)/2020_y,2)*100 as "%_rate_2021",
    round((2022_y-2021_y)/2021_y,2)*100 as "%_rate_2022",
    round((2023_y-2022_y)/2022_y,2)*100 as "%_rate_2023"
from cte;

/* 7.Picture yourself as a data architect responsible for database management. Companies in US and AU(Australia) decided to create a hybrid model for employees 
 they decided that employees earning salaries exceeding $90000 USD, will be given work from home. You now need to update the remote work ratio for eligible employees,
 ensuring efficient remote work management while implementing appropriate error handling mechanisms for invalid input parameters.*/
    
create table hybrid_model as select * from salaries;

update hybrid_model
set remote_ratio = 100
where company_location in ("US","AU") and salary_in_usd > 90000;

select * from hybrid_model;

/* 8. In year 2024, due to increase demand in data industry , there was  increase in salaries of data field employees.
                   Entry Level-35%  of the salary.
                   Mid junior – 30% of the salary.
                   Immediate senior level- 22% of the salary.
                   Expert level- 20% of the salary.
                   Director – 15% of the salary.
you have to update the salaries accordingly and update it back in the original database. */

 UPDATE hybrid_model
 SET salary_in_usd=CASE
		WHEN experience_level="EN" THEN salary_in_usd*1.35
        WHEN experience_level="MI" THEN salary_in_usd*1.30
        WHEN experience_level="SE" THEN salary_in_usd*1.22
        WHEN experience_level="EX" THEN salary_in_usd*1.20
        WHEN experience_level="DX" THEN salary_in_usd*1.15
        ELSE salary_in_usd
        END
where work_year=2024;
SELECT * FROM hybrid_model;

/*9. You are a researcher and you have been assigned the task to Find the year with the highest average salary for each job title.*/

with cte as (
	select 
		work_year,job_title,avg(salary_in_usd) as "avg_salary" 
	from salaries
	group by 1,2)

select 
	job_title,work_year,avg_salary 
from 
	(select 
		job_title,work_year,avg_salary,
        RANK() OVER(PARTITION BY job_title ORDER BY avg_salary DESC) as "rank_sal" 
	FROM cte) t
where rank_sal=1 ;

/*10. You have been hired by a market research agency where you been assigned the task to show the percentage of different employment type (full time, part time) in 
Different job roles, in the format where each row will be job title, each column will be type of employment type and  cell value  for that row and column will show 
the % value*/

select job_title, 
	COUNT(case when employment_type="FT" then 1 end) *100 /COUNT(*) as "FT",
    COUNT(case when employment_type="PT" then 1 end) *100 /COUNT(*) as "PT",
    COUNT(case when employment_type="CT" then 1 end) *100 /COUNT(*) as "CT",
    COUNT(case when employment_type="FL" then 1 end) *100 /COUNT(*) as "FL"
    from salaries
    group by 1;

select count(*) from salaries

