-- Databricks notebook source
-- employee_role table creation
create table Employee_Role(
EID int,
Role varchar(25)
)

-- COMMAND ----------


Insert into Employee_Role values( 101,'Manager'),
                                ( 102,'Lead Engineer'),
                                ( 103,'Trainee'),
                                ( 104,'Trainee'),
                                ( 105,'Engineer'),
                                ( 106,'Engineer'),
                                ( 107,'Engineer')

-- COMMAND ----------

-- employee_salary table creation
create table Employee_Salary(
EID int,
Salary int,
DOB date
)

-- COMMAND ----------

Insert into Employee_Salary values( 101,15000,'1990-10-12'),
                                ( 102,17000, '1991-08-22'),
                                ( 103,1000, '1989-02-23'),
                                ( 104,13000, '1988-03-09'),
                                ( 105,1500, '1987-02-24'),
                                ( 106,12000, '1987-02-24'),
                                ( 107,15000, '1987-02-24')

-- COMMAND ----------

--- Find employee with highest salary
select EID from  
(
select EID,Salary, dense_rank() over(order by Salary desc) as Salary_rank from Employee_Salary 
) as emp_rank where emp_rank.Salary_rank = 1

-- COMMAND ----------

select EID,Salary, dense_rank() over(order by Salary desc) as Salary_rank from Employee_Salary

-- COMMAND ----------

select e.EID, e.Role,s.EID, s.Salary, s.DOB, dense_rank() over(partition by e.Role order by s.Salary desc) emp_rank
from Employee_Role e  inner join Employee_Salary s
on e.EID = s.EID

-- COMMAND ----------

--- List of Employees earning more than Engineer
select s.EID from Employee_Salary s
where  s.Salary  >
 (
select max(s.Salary) as max_sal
from Employee_Role e  inner join Employee_Salary s
on e.EID = s.EID
where e.Role = 'Engineer' )

-- COMMAND ----------

 --- Find youngest employee id.
select EID from  
(
select EID,Salary, dense_rank() over(order by Salary asc) as Salary_rank from Employee_Salary 
) as emp_rank where emp_rank.Salary_rank = 1

-- COMMAND ----------


