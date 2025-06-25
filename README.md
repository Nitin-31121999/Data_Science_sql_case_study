# Data Science Jobs SQL Case Study

## Description
This project involves a detailed analysis of a dataset related to job market trends, specifically focusing on data science jobs. The dataset, named 'salaries', contains 13,972 records and 11 columns with details about work experience, employment type, job title, salary, and other relevant information. 

The project aims to extract valuable insights from the data, such as the distribution of employees across companies of various sizes, highest paying part-time job titles, countries with higher than average mid-level salaries, and more. 

## Table Structure
The 'salaries' table includes the following columns:

- work_year (INT)
- experience_level (TEXT)
- employment_type (TEXT)
- job_title (TEXT)
- salary (INT)
- salary_currency (TEXT)
- salary_in_usd (INT)
- employee_residence (TEXT)
- remote_ratio (INT)
- company_location (TEXT)
- company_size (TEXT)

## Insights
The project aims to provide the following insights:

1. Employment distribution for different types of companies based on their size in 2021.
2. Top 3 job titles with the highest average salary for part-time positions in the year 2023.
3. Countries where the average mid-level salary is higher than the overall mid-level salary for the year 2023.
4. Company locations with the highest and lowest average salary for senior-level employees in 2023.
5. The annual salary growth rate for various job titles.
6. The top three countries with the highest salary growth rate for entry-level roles from 2020 to 2023.
7. Update the remote work ratio for employees earning salaries exceeding $90000 USD in the US and Australia.
8. Update salaries for various employee levels due to an increase in demand in the data industry in 2024.
9. The year with the highest average salary for each job title.
10. The percentage of different employment types in different job roles.

## Key Insights

![Screenshot 2025-06-25 094326](https://github.com/user-attachments/assets/a0de501e-cf6d-4377-9a01-08b2313e5550)

![Screenshot 2025-06-25 094318](https://github.com/user-attachments/assets/310bc4b0-c934-4620-a1d7-311dcc0818f7)

![Screenshot 2025-06-25 094306](https://github.com/user-attachments/assets/b0ab174b-8f40-4fbe-838c-ee63364ed616)



## SQL Skills Applied
In this project, various SQL skills were utilized to answer the research questions and derive insights. These skills include:

- CRUD operations: Inserting, updating, and deleting data from the database.
- Joins: Used to combine rows from two or more tables, based on a related column.
- CTEs: Common Table Expressions were used to create temporary result sets for better readability and ease of use.
- Stored Procedures: Used to encapsulate a series of SQL statements into a single procedure, which was called multiple times in the project.
- Window functions: Used to perform calculations across a set of rows that are related to the current row.

## Requirements
- SQL for data extraction and manipulation.
- Data Analysis skills for understanding and interpreting data.
