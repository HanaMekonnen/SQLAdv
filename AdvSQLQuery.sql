drop table if exists department
drop table if exists employees
drop table if exists departments
drop table if exists projects
drop table if exists managers


-- 1. CREATE TABLES
CREATE TABLE departments (
    id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    dept_id INT,
	department VARCHAR(50),
    manager_id INT,
    hire_date DATE,
    FOREIGN KEY (dept_id) REFERENCES departments(id)
);


--2. INSERT DATA
--Departments
INSERT INTO departments (id, dept_name) VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing');



--Employees
INSERT INTO employees (id, name, salary, dept_id, department, manager_id, hire_date) VALUES
(1, 'Alice', 90000, 1, 'IT', NULL, '2020-01-15'),
(2, 'Bob', 80000, 1, 'IT', 1, '2020-03-10'),
(3, 'Charlie', 70000, 2, 'HR', 1, '2021-06-01'),
(4, 'David', 60000, 2, 'HR',  3, '2021-07-15'),
(5, 'Eva', 75000, 3, 'Finance', 1, '2022-02-20'),
(6, 'Frank', 50000, 3,  'Finance', 5, '2022-03-18'),
(7, 'Grace', 85000, 1,  'IT', 2, '2020-11-11'),
(8, 'Hannah', 95000, 4, 'Marketing', NULL, '2019-09-09'),
(9, 'Ian', 40000, 4,  'Marketing', 8, '2023-01-01'),
(10, 'Jack', 30000, NULL, NULL, NULL, '2023-05-05'),
(11, 'Kevin', 70000, 1, 'IT',  2, '2021-08-08'),
(12, 'Laura', 65000, 2, 'HR', 3, '2022-10-10'),
(13, 'Mike', 72000, 3, 'Finance', 5, '2021-12-12'),
(14, 'Nina', 88000, 1, 'IT', 1, '2020-04-04'),
(15, 'Oscar', 30000, 4,  'Marketing', 8, '2023-06-06'),
(16, 'Alice', 90000, 1, 'IT', NULL, '2020-01-15'),
(17, 'Bob', 80000, 1, 'IT', 1, '2020-03-10'),
(18, 'Charlie', 70000, 2, 'HR', 1, '2021-06-01');

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50),
    dept_id INT
);

INSERT INTO projects VALUES
(1, 'AI System', 1),
(2, 'HR Analytics', 2),
(3, 'Budget Planning', 3),
(4, 'Ad Campaign', 4);


CREATE TABLE managers (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO managers (id, name) VALUES
(1, 'Alice'),
(2, 'Hannah'),
(3, 'Robert'),
(4, 'Kevin');


--ALL Codes

--EASY

--1. Get all employees
SELECT * FROM employees;

--2. Select specific columns
SELECT name, salary FROM employees;

--3. Filter rows (WHERE)
SELECT * FROM employees
WHERE salary > 50000;

--4. AND condition
SELECT * FROM employees
WHERE department = 'IT' AND salary > 60000;

--5. OR condition
SELECT * FROM employees
WHERE department = 'HR' OR department = 'Finance';

--6. LIKE (pattern)
SELECT * FROM employees
WHERE name LIKE 'A%';

--7. BETWEEN
SELECT * FROM employees
WHERE salary BETWEEN 40000 AND 80000;

--8. IN clause
SELECT * FROM employees
WHERE department IN ('IT', 'HR');

--9. ORDER BY
SELECT * FROM employees
ORDER BY salary DESC;

--10. LIMIT
SELECT * FROM employees
LIMIT 5;
--LIMIT 1 OFFSET 2


--11. COUNT
SELECT COUNT(*) FROM employees;

--12. DISTINCT
SELECT DISTINCT department FROM employees;

--13. IS NULL
SELECT * FROM employees
WHERE manager_id IS NULL;

--14. UPDATE
UPDATE employees
SET salary = salary + 5000
WHERE department = 'IT';


--🟡 MEDIUM (16–35)

--16. GROUP BY
SELECT department, COUNT(*)
FROM employees
GROUP BY department;

--17. HAVING
SELECT department, COUNT(*)
FROM employees
GROUP BY department
HAVING COUNT(*) > 5;

--18. INNER JOIN
SELECT e.id , e.name, d.dept_name
FROM employees e
JOIN departments d ON e.dept_id = d.id;

--19. LEFT JOIN
SELECT e.id , e.name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.id;

--20. RIGHT JOIN
SELECT e.id , e.name, d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.id;

--21. FULL OUTER JOIN
SELECT *
FROM employees e
FULL OUTER JOIN departments d
ON e.dept_id = d.id;

SELECT AVG(salary) FROM employees

--22. Subquery (WHERE)
SELECT id, name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

--23. Subquery (FROM)
SELECT  dept_id, department, avg_salary
FROM (
  SELECT department, dept_id, AVG(salary) AS avg_salary
  FROM employees
  GROUP BY department, dept_id
) t;

--24. EXISTS
SELECT id, name
FROM employees e
WHERE EXISTS (
  SELECT 1 FROM departments d WHERE e.dept_id = d.id
);

--25. CASE statement
SELECT id, name,
CASE 
  WHEN salary > 70000 THEN 'High'
  WHEN salary BETWEEN 40000 AND 70000 THEN 'Medium'
  ELSE 'Low'
END AS salary_level
FROM employees;

--26. Aggregate functions
SELECT MIN(salary), MAX(salary), AVG(salary)
FROM employees;

--27. Top N salaries
SELECT * FROM employees
ORDER BY salary DESC
LIMIT 3;

--28. Duplicate records
SELECT name, COUNT(*)
FROM employees
GROUP BY  name
HAVING COUNT(*) > 1;

--29. Remove duplicates
DELETE FROM employees
WHERE id NOT IN (
  SELECT MIN(id)
  FROM employees
  GROUP BY name
);

--30. Second highest salary
SELECT MAX(salary)
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);

--31. Nth highest salary
SELECT salary
FROM employees
ORDER BY salary DESC
LIMIT 1 OFFSET 2;

SELECT salary
FROM employees
ORDER BY salary DESC
OFFSET 8 ROWS
FETCH NEXT 1 ROW ONLY;

SELECT salary
FROM employees
ORDER BY salary DESC
OFFSET 1 ROWS 				--- (N – 1) skipping
FETCH NEXT 1 ROW ONLY;


--32. Employees with no department
SELECT *
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.id
WHERE d.id IS NULL;

--33. Self join
SELECT e.name, m.name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id;

--34. UNION
SELECT id, name FROM employees
UNION
SELECT id, name FROM managers;

--35. UNION ALL
SELECT id, name FROM employees
UNION ALL
SELECT id, name FROM managers;





--🔴 HARD (36–50)
--36. Window function (ROW_NUMBER)
SELECT name, salary,
ROW_NUMBER() OVER (ORDER BY salary DESC) AS rank
FROM employees;

--37. RANK vs DENSE_RANK
SELECT name, salary,
ROW_NUMBER() OVER (ORDER BY salary DESC) AS RowNumber,
RANK() OVER (ORDER BY salary DESC)AS Rankk,
DENSE_RANK() OVER (ORDER BY salary DESC) AS DenseRank
FROM employees;

--38. Partition by
SELECT name, dept_id, salary,
RANK() OVER (PARTITION BY dept_id ORDER BY salary DESC)
FROM employees;

--39. Running total
SELECT id, salary,
SUM(salary) OVER (ORDER BY id) AS running_total
FROM employees;

--40. Moving average
SELECT id, salary,
AVG(salary) OVER (ORDER BY id ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
FROM employees;

--41. Lead/Lag
SELECT name, salary,
LAG(salary) OVER (ORDER BY salary) AS LAGG,
LEAD(salary) OVER (ORDER BY salary) AS LEADD
FROM employees;

--42. Find gaps in sequence
SELECT id + 1 AS gap_start
FROM employees
WHERE (id + 1) NOT IN (SELECT id FROM employees);

--43. Recursive CTE
WITH RECURSIVE emp_hierarchy AS (
  SELECT id, manager_id, name
  FROM employees
  WHERE manager_id IS NULL
  UNION ALL
  SELECT e.id, e.manager_id, e.name
  FROM employees e
  JOIN emp_hierarchy h ON e.manager_id = h.id
)
SELECT * FROM emp_hierarchy;

--44. Pivot (conditional aggregation)
SELECT
  SUM(CASE WHEN dept_id = 1 THEN salary END) AS dept1,
  SUM(CASE WHEN dept_id = 2 THEN salary END) AS dept2
FROM employees;

--45. Unpivot
SELECT dept, salary
FROM (
  SELECT dept1, dept2 FROM table1
) t
UNPIVOT (salary FOR dept IN (dept1, dept2)) u;

--46. Top 3 per department
SELECT *
FROM (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY salary DESC) rn
  FROM employees
) t
WHERE rn <= 3;

--47. Delete duplicates using CTE
WITH cte AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY name ORDER BY id) rn
  FROM employees
)
DELETE FROM cte WHERE rn > 1;

--48. Find median salary
SELECT AVG(salary)
FROM (
  SELECT salary,
         ROW_NUMBER() OVER (ORDER BY salary) rn,
         COUNT(*) OVER () cnt
  FROM employees
) t
WHERE rn IN (cnt/2, cnt/2 + 1);

--49. Find employees earning more than manager
SELECT e.name
FROM employees e
JOIN employees m ON e.manager_id = m.id
WHERE e.salary > m.salary;

--50. Find consecutive records
SELECT id
FROM (
  SELECT id,
         id - ROW_NUMBER() OVER (ORDER BY id) AS grp
  FROM employees
) t
GROUP BY grp
HAVING COUNT(*) >= 3;

----------------------------------------------------------------------------------------------------------------------------------------------
--===============================================================================================================================================

--🟢 PART 2 / EASY (1–15)
--1. Find employees hired after 2021
SELECT * 
FROM employees
WHERE hire_date > '2021-12-31';

--2. Extract year from hire date
SELECT name, EXTRACT(YEAR FROM hire_date) AS hire_year
FROM employees;

--3. Convert name to uppercase
SELECT id, UPPER(name) FROM employees;

--4. Length of employee names
SELECT name, LENGTH(name) FROM employees;

--5. Concatenate name and salary
SELECT name || ' earns ' || salary AS info
FROM employees;

--6. Round salary
SELECT name, salary, ROUND(salary, -3) FROM employees;

--7. Current date
SELECT CURRENT_DATE;

--8. Employees hired in last 2 years
SELECT *
FROM employees
WHERE hire_date >= CURRENT_DATE - INTERVAL '2 years';

--9. Replace text
SELECT id, name, REPLACE(name, 'a', 'X')
FROM employees;

--10. COALESCE (handle NULL)
SELECT name, dept_id, COALESCE(dept_id, 0) AS dept_idC
FROM employees;

--11. Count employees per department (including NULL)
SELECT dept_id, COUNT(*)
FROM employees
GROUP BY dept_id;

--12. Alias usage
SELECT name AS employee_name
FROM employees;

--13. DISTINCT with multiple columns
SELECT DISTINCT dept_id, salary
FROM employees;

--14. LIMIT with OFFSET
SELECT *
FROM employees
--LIMIT 5 OFFSET 5;
OFFSET 5 ROWS 				--- (N – 1) skipping…..9th highest salary
FETCH NEXT 5 ROW ONLY;

--15. Random rows
SELECT *
FROM employees
ORDER BY RANDOM()
LIMIT 3;



--🟡 MEDIUM (16–35)
--16. Employees with same salary
SELECT e1.name, e2.name, e1.salary
FROM employees e1
JOIN employees e2 
ON e1.salary = e2.salary AND e1.id < e2.id;

--17. Department with highest avg salary
SELECT dept_id
FROM employees
GROUP BY dept_id
ORDER BY AVG(salary) DESC
--LIMIT 1;

--18. Employees above department average
SELECT AVG(salary)
  FROM employees
SELECT *
FROM employees e
WHERE salary > (
  SELECT AVG(salary)
  FROM employees
  WHERE dept_id = e.dept_id
)
order by salary;

--19. Count employees under each manager
SELECT manager_id, COUNT(*)
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id;

--20. Employees hired same day
SELECT hire_date, COUNT(*)
FROM employees
GROUP BY hire_date
HAVING COUNT(*) > 1;

--21. Max salary per department
SELECT dept_id, department, MAX(salary)
FROM employees
GROUP BY dept_id, department;

--22. Employees with max salary in each dept
SELECT *
FROM employees e
WHERE salary = (
  SELECT MAX(salary)
  FROM employees
  WHERE dept_id = e.dept_id
);

--23. Departments with no employees
SELECT *
FROM departments d
LEFT JOIN employees e ON d.id = e.dept_id
WHERE e.id IS NULL;

SELECT *
FROM departments d
RIGHT JOIN employees e ON d.id = e.dept_id
WHERE d.id IS NULL;

--24. Employees not in IT
SELECT *
FROM employees
WHERE dept_id != 1 OR dept_id IS NULL;

--25. Top 2 salaries per department
SELECT *
FROM (
  SELECT *,
  ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY salary DESC) rn
  FROM employees
) t
WHERE rn <= 2;

--26. Count distinct managers
SELECT COUNT(DISTINCT manager_id)
FROM employees;

--27. Employees whose name contains 'a' twice
SELECT *
FROM employees
WHERE LENGTH(name) - LENGTH(REPLACE(name, 'a', '')) >= 2;

--28. Salary difference from max
SELECT MAX(salary) FROM employees

SELECT name, salary,
(SELECT MAX(salary) FROM employees) - salary AS diff
FROM employees;

--29. Employees with no subordinates
SELECT *
FROM employees e
WHERE id NOT IN (
  SELECT DISTINCT manager_id FROM employees WHERE manager_id IS NOT NULL
);

--30. Count employees hired each year
SELECT EXTRACT(YEAR FROM hire_date) AS year, COUNT(*)
FROM employees
GROUP BY year;

--31. Department salary total
SELECT dept_id, SUM(salary)
FROM employees
GROUP BY dept_id;

--32. Employees earning within top 10%
SELECT *
FROM employees
WHERE salary >= (
  SELECT PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY salary)
  FROM employees
);

--33. Employees hired before manager
SELECT e.name
FROM employees e
JOIN employees m ON e.manager_id = m.id
WHERE e.hire_date < m.hire_date;

--34. Count employees per salary range
SELECT
CASE 
  WHEN salary < 50000 THEN 'Low'
  WHEN salary BETWEEN 50000 AND 80000 THEN 'Mid'
  ELSE 'High'
END AS range,
COUNT(*)
FROM employees
GROUP BY range;

--35. Average salary excluding highest
SELECT AVG(salary)
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);



--🔴 HARD (36–50)
--36. Detect salary increase over previous employee
SELECT name, salary,
LAG(salary) OVER (ORDER BY id) AS prev_salary,
LEAD(salary) OVER (ORDER BY id) AS next_salary
FROM employees;

--37. Rank employees by hire date per dept
SELECT name, dept_id, hire_date,
ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY hire_date)
FROM employees;

--38. Longest tenure employee
SELECT *
FROM employees
ORDER BY hire_date
LIMIT 1;

--39. Employees hired consecutively
SELECT *
FROM (
  SELECT *,
  hire_date - ROW_NUMBER() OVER (ORDER BY hire_date) AS grp
  FROM employees
) t;

--40. First employee per department
SELECT *
FROM (
  SELECT *,
  ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY hire_date) rn
  FROM employees
) t
WHERE rn = 1;

--41. Last employee per department
SELECT *
FROM (
  SELECT *,
  ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY hire_date DESC) rn
  FROM employees
) t
WHERE rn = 1;

--42. Salary percentile rank
SELECT name, salary,
PERCENT_RANK() OVER (ORDER BY salary)
FROM employees;

--43. Bucket employees into 4 groups
SELECT name, salary,
NTILE(4) OVER (ORDER BY salary)
FROM employees;

--44. Find duplicate salaries using window
SELECT *
FROM (
  SELECT *, COUNT(*) OVER (PARTITION BY salary) cnt
  FROM employees
) t
WHERE cnt > 1;

--45. Employees earning above running average
SELECT *
FROM (
  SELECT id, name, salary,
  AVG(salary) OVER (ORDER BY id) avg_sal
  FROM employees
) t
WHERE salary > avg_sal;

--46. Reverse running total
SELECT id, salary,
SUM(salary) OVER (ORDER BY id DESC)
FROM employees;

--47. Compare employee vs department average
SELECT name, dept_id, salary,
AVG(salary) OVER (PARTITION BY dept_id) dept_avg
FROM employees;

--48. Find departments where all salaries > 50k
SELECT dept_id
FROM employees
GROUP BY dept_id
HAVING MIN(salary) > 50000;


SELECT dept_id, name, salary
FROM employees
GROUP BY dept_id, name, salary
HAVING MIN(salary) > 50000;

--49. Employees closest to average salary
SELECT *
FROM employees
ORDER BY ABS(salary - (SELECT AVG(salary) FROM employees))
LIMIT 1;

--50. Find gaps in hire dates
SELECT hire_date,
LAG(hire_date) OVER (ORDER BY hire_date) AS previous_date,
LEAD(hire_date) OVER (ORDER BY hire_date) AS next_date
FROM employees;


-- PART 3 -----===========================================================================================================================

CREATE VIEW high_salary_employees AS
SELECT id, name, salary, dept_id
FROM employees
WHERE salary > 70000;

SELECT * FROM high_salary_employees;


CREATE VIEW employee_department_view AS
SELECT 
    e.name,
    e.salary,
    d.dept_name
FROM employees e
JOIN departments d
ON e.dept_id = d.id;

SELECT * FROM employee_department_view;


CREATE VIEW department_salary_summary AS
SELECT 
    d.dept_name,
    SUM(e.salary) AS total_salary,
    AVG(e.salary) AS avg_salary,
    COUNT(e.id) AS employee_count
FROM departments d
LEFT JOIN employees e
ON d.id = e.dept_id
GROUP BY d.dept_name;

SELECT * FROM department_salary_summary;


CREATE PROCEDURE GetEmployeesByDepartment
    @DeptID INT
AS
BEGIN
    SELECT *
    FROM employees
    WHERE dept_id = @DeptID;
END;

EXEC GetEmployeesByDepartment @DeptID = 1; --leyebicha without the code metrate enchilalegn


CREATE PROCEDURE IncreaseSalary
    @EmpID INT,
    @PercentIncrease INT
AS
BEGIN
    UPDATE employees
    SET salary = salary + (salary * @PercentIncrease / 100)
    WHERE id = @EmpID;
END;

EXEC IncreaseSalary @EmpID = 2, @PercentIncrease = 10;



CREATE PROCEDURE DepartmentSalaryStats
    @DeptID INT
AS
BEGIN
    SELECT
        MAX(salary) AS max_salary,
        MIN(salary) AS min_salary,
        AVG(salary) AS avg_salary
    FROM employees
    WHERE dept_id = @DeptID;
END;


EXEC DepartmentSalaryStats @DeptID = 1;



CREATE TABLE #high_salary (
    id INT,
    name VARCHAR(50),
    salary INT
);

INSERT INTO #high_salary
SELECT id, name, salary
FROM employees
WHERE salary > 70000;

select * from #high_salary				-- can run separetly


WITH dept_avg AS (
    SELECT dept_id,
           AVG(salary) AS avg_salary
    FROM employees
    GROUP BY dept_id
)
SELECT *									--together run can not separetely run
FROM dept_avg;



CREATE TRIGGER prevent_negative_salary
ON employees
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE salary < 0
    )
    BEGIN
        PRINT 'Negative salary not allowed';
    END
    ELSE
    BEGIN
        INSERT INTO employees
        SELECT * FROM inserted;
    END
END;


Create Log Table
CREATE TABLE salary_log (
    employee_id INT,
    old_salary INT,
    new_salary INT,
    changed_date DATETIME
);


CREATE TRIGGER salary_update_trigger
ON employees
AFTER UPDATE
AS
BEGIN
    INSERT INTO salary_log (
        employee_id,
        old_salary,
        new_salary,
        changed_date
    )
    SELECT
        d.id,
        d.salary,
        i.salary,
        GETDATE()
    FROM deleted d
    JOIN inserted i
    ON d.id = i.id
    WHERE d.salary <> i.salary;
END;



CREATE TRIGGER auto_hire_date
ON employees
AFTER INSERT
AS
BEGIN
    UPDATE employees
    SET hire_date = GETDATE()
    WHERE hire_date IS NULL;
END;



CREATE INDEX idx_salary
ON employees(salary);

--Why?
--Queries like below become faster:

SELECT *
FROM employees
WHERE salary > 70000;


CREATE INDEX idx_dept_salary
ON employees(dept_id, salary);
--Best For
SELECT *
FROM employees
WHERE dept_id = 1
AND salary > 70000;


BEGIN TRANSACTION;

UPDATE employees
SET salary = salary + 5000
WHERE id = 2;

COMMIT;


BEGIN TRANSACTION;

UPDATE employees
SET salary = salary - 10000
WHERE id = 3;

ROLLBACK;


BEGIN TRANSACTION;

UPDATE employees
SET salary = salary + 1000
WHERE id = 1;

UPDATE employees
SET salary = salary - 1000
WHERE id = 2;

COMMIT;


ALTER TABLE employees
ADD CONSTRAINT chk_salary
CHECK (salary >= 0);


CREATE TABLE employee_phones (
    emp_id INT,
    phone_number VARCHAR(20)
);
 
select * from employee_phones


employees(dept_id)
departments(id, dept_name)


SET SHOWPLAN_ALL ON;

SELECT *
FROM employees
WHERE salary > 70000;

