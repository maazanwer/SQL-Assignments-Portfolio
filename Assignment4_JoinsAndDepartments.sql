CREATE TABLE Empls (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(100) UNIQUE,
    DepartmentID INT,
    HireDate DATE,
    Salary DECIMAL(10, 2)
);

CREATE TABLE Depts (
    DepartmentID INT PRIMARY KEY,
    DepartmentName NVARCHAR(100)
);


INSERT INTO Empls (EmployeeID, FirstName, LastName, Email, DepartmentID, HireDate, Salary)
VALUES 
(1, 'John', 'Smith', 'john.smith@example.com', 101, '2021-06-15', 75000.00),
(2, 'Jane', 'Doe', 'jane.doe@example.com', 102, '2020-03-10', 85000.00),
(3, 'Michael', 'Johnson', 'michael.johnson@example.com', 101, '2019-11-22', 95000.00),
(4, 'Emily', 'Davis', 'emily.davis@example.com', 103, '2022-01-05', 68000.00),
(5, 'William', 'Brown', 'william.brown@example.com', 102, '2018-07-19', 80000.00);

INSERT INTO Depts (DepartmentID, DepartmentName)
VALUES
(101, 'Human Resources'),
(102, 'Finance'),
(103, 'IT');

--1)Write a SQL query to list the names of employees along with the names of the departments they work in.

select * from empls
inner join depts
on empls.DepartmentID=Depts.DepartmentID

--2)Write a SQL query to list all the departments and the employees working in them, including departments with no employees.

select depts.departmentname,empls.FirstName,empls.LastName from Depts
left join Empls
on depts.DepartmentID=empls.DepartmentID

--3)Write a SQL query to find the names of employees who do not belong to any department (i.e., no matching department ID).

select e.FirstName,e.LastName,d.DepartmentName from Depts as d
full join empls as e
on e.DepartmentID=d.DepartmentID
where d.DepartmentName is null


--4)Write a SQL query to list the names of employees who work in the same department as 'Jane Doe'.

select * from empls
where empls.DepartmentID in (select para from(
select DepartmentID as [para] from empls
where firstname='jane' and LastName='doe'
)as coworker)

--5)Write a SQL query to find the department with the highest total salary paid to its employees.


with dept_sums as(
select depts.DepartmentName as [h_dept],sum(empls.Salary) as[dpt_wise_sal] from Depts
inner join Empls
on depts.DepartmentId=empls.DepartmentID
group by depts.DepartmentName) select h_dept,dpt_wise_sal from dept_sums
where dpt_wise_sal= (select max(dpt_wise_sal) from dept_sums)
