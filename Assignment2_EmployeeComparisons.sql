CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(100) UNIQUE,
    DepartmentID INT,
    HireDate DATE,
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, DepartmentID, HireDate, Salary)
VALUES 
(1, 'John', 'Smith', 'john.smith@example.com', 101, '2021-06-15', 75000.00),
(2, 'Jane', 'Doe', 'jane.doe@example.com', 102, '2020-03-10', 85000.00),
(3, 'Michael', 'Johnson', 'michael.johnson@example.com', 101, '2019-11-22', 95000.00),
(4, 'Emily', 'Davis', 'emily.davis@example.com', 103, '2022-01-05', 68000.00),
(5, 'William', 'Brown', 'william.brown@example.com', 102, '2018-07-19', 80000.00);


--1)Write a SQL query to find the names of employees who have a salary higher than the average salary of all employees.

select * from Employees
where salary >(select avg(salary) from employees)

--2)Write a SQL query to list the employee names and their departments for employees who were hired after the oldest employee in the company.

select * from employees
where HireDate > (select  min(HireDate) from Employees)

--3)Write a SQL query to find the details of the employee(s) with the highest salary.

select * from employees
where salary=(select max(salary) from employees)

--4)Write a SQL query to find the names of employees who work in the same department as 'John Smith'.

select * from employees
where DepartmentID =(select departmentid from employees where firstname='john')

--5)Write a SQL query to find the names of employees who do not belong to the department with the highest average salary.

SELECT EmployeeID
	,FirstName
	,lastname
FROM Employees
WHERE employees.DepartmentID IN (
		SELECT deptid_min
		FROM (
			SELECT DepartmentID AS [deptid_min]
				,avg(salary) AS [min_dept]
			FROM employees
			GROUP BY DepartmentID
			HAVING avg(salary) < (
					SELECT max(avg_salary)
					FROM (
						SELECT DepartmentID
							,avg(salary) AS [avg_salary]
						FROM employees
						GROUP BY DepartmentID
						) AS dept_avg
					)
			) AS emp_lessavg
		)

