-- SQL CTE Practice
-- Database: MySQL 8.0
-- Author: Kruthi G C

-- Create Database
CREATE DATABASE sql_practice;

-- Using the same database
USE sql_practice;

-- Just a precautionary step
DROP TABLE IF EXISTS employees;

-- Create table 'employees'
CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    joining_date DATE,
    status VARCHAR(10)
);

-- Inserting Values to out 'employees' table
INSERT INTO employees (emp_name, department, salary, joining_date, status) VALUES
('Asha', 'HR', 40000, '2021-01-10', 'ACTIVE'),
('Ravi', 'HR', 45000, '2022-03-15', 'ACTIVE'),
('Neha', 'IT', 70000, '2020-07-01', 'ACTIVE'),
('Arjun', 'IT', 80000, '2019-06-20', 'ACTIVE'),
('Kiran', 'IT', 60000, '2023-02-01', 'INACTIVE'),
('Pooja', 'Finance', 50000, '2021-11-11', 'ACTIVE'),
('Manoj', 'Finance', 55000, '2020-05-05', 'ACTIVE'),
('Suman', 'Sales', 30000, '2022-09-09', 'ACTIVE'),
('Raj', 'Sales', 35000, '2021-08-08', 'ACTIVE'),
('Anita', 'Sales', 40000, '2023-01-01', 'ACTIVE');

-- To check the values inserted in the table 'employees' created
SELECT * FROM employees;

-- CTEs practiced:

-- 1. Using a CTE, show all ACTIVE employees.
WITH active_employees As(
SELECT *
FROM employees
WHERE status= 'ACTIVE')

SELECT * FROM active_employees;

-- 2.Using a CTE, show employees who joined after 2021-01-01.
WITH emp_after_sp_time AS(
SELECT * 
FROM employees
WHERE joining_date>'2021-01-01'
)

SELECT * FROM emp_after_sp_time;

-- 3.Using a CTE, show IT department employees with salary > 60,000.
WITH it_dept_gr_60000 AS(
SELECT *
FROM employees
WHERE department ='IT' AND salary>60000
)

SELECT * FROM it_dept_gr_60000;

-- 4.Create a CTE that selects only emp_name, department, and salary
-- Then select all rows from that CTE.

WITH general_info AS(
SELECT emp_name,department,salary
FROM employees
)

SELECT * FROM general_info;

-- 5.Using a CTE, sort employees by salary descending.
WITH sal_desc AS(
SELECT *
FROM employees
ORDER BY salary DESC)
SELECT * FROM sal_desc;

-- The above one is correct, but ORDER BY should usually be in final SELECT and not inside the CTE
-- Preferred way:
WITH sal_desc AS(
SELECT * 
FROM employees
)
SELECT *
FROM sal_desc
ORDER BY salary DESC;


 
-- 6.Using a CTE, find average salary per department.
WITH dept_avg AS(
SELECT department,AVG(salary) as avg_salary
FROM employees
GROUP BY department
)
SELECT * FROM dept_avg;

-- 7.Using a CTE, show departments where average salary > 50,000.
WITH dept_ab_50000 AS(
SELECT department, AVG(salary) as avg_savary
FROM employees
GROUP BY department
HAVING AVG(salary)>50000
)
SELECT * FROM dept_ab_50000;

-- 8.Using a CTE, count ACTIVE employees per department.
WITH active_users_per_dept AS(
SELECT department,COUNT(*) as active_users
FROM employees
WHERE status= 'ACTIVE'
GROUP BY department
-- HAVING status LIKE 'ACTIVE'
)
SELECT * FROM active_users_per_dept;

-- 9. Using a CTE, show departments ordered by total salary (descending).
WITH dept_total_salary_desc AS(
SELECT department,SUM(salary) as total_salary_dept
FROM employees
GROUP BY department
ORDER BY total_salary_dept desc
)
SELECT * FROM dept_total_salary_desc;

-- Same here also, ORDER BY is preferred outside
WITH dept_total_salary AS(
SELECT department,SUM(salary) as total_salary
FROM employees
GROUP BY department
)
SELECT * 
FROM dept_total_salary
ORDER BY total_salary DESC;

-- 10.Using a CTE, find departments having more than 2 employees.
WITH dept_with_more_than_2_emp AS(
SELECT department-- ,COUNT(*)
FROM employees
GROUP BY department
HAVING COUNT(*)>2)
SELECT * FROM dept_with_more_than_2_emp;
SELECT * FROm employees;

-- 11. Using a CTE, find highest salary in each department
WITH highest_sal_in_each_dept AS(
SELECT department,MAX(salary) AS max_sal_in_dept
FROM employees
GROUP BY department
)
SELECT *
FROM highest_sal_in_each_dept
ORDER BY max_sal_in_dept;

-- 12.Using a CTE, find employees who earn more than the average salary of their department
WITH dept_avg AS (
    SELECT department, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department
)
SELECT e.emp_name,
       e.department,
       e.salary
FROM employees e
JOIN dept_avg d ON e.department = d.department
WHERE e.salary > d.avg_salary;


-- 13. Using a CTE, find departments with total salary greater than 200,000
WITH total_sal_greater_than_200000 AS(
SELECT department,SUM(salary)AS total_salary
FROM employees
GROUP BY department
)
SELECT department,total_salary
FROM total_sal_greater_than_200000
WHERE total_salary>200000;
SELECT * FROM employees;

-- 14. Using a CTE, find ACTIVE employees who earn above the company average salary
WITH comp_avg AS (
    SELECT AVG(salary) AS comp_avg_sal
    FROM employees
)
SELECT emp_name, salary, status
FROM employees
WHERE status = 'ACTIVE'
  AND salary > (SELECT comp_avg_sal FROM comp_avg);


