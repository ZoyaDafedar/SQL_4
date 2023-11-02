use V#Assign
--Table 4

create table Department1
(
Id int primary key identity,
Name varchar(50)
)
--Inserting Values
insert into Department1 values('IT'),('HR'),('Admin')
--Select Records
select Id,Name from Department1

--Create table Gender
create Table Gender
(
Id int primary key identity,
Name varchar(30),
)
--inserting
insert into Gender values('male'),('Female'),('Unknown')

select * from Gender

--Employee table
create table Employee1
(
Id int primary key identity,
Name varchar(50),
GenderId int,
Salary int,
DId int
)
--Inserting 
insert into Employee1 values('Ashish',1,9000,3),('Ritesh',1,9500,null),('Jyoti',2,5000,1)
					,('Dheeraj',1,5200,1),('Satish',null,5200,1),('Archana',2,9000,1)

select * from Employee1

/*1.Write a query to find all Employee Names, Gender Name and Department Name. 
If it’s gender not mentioned it should come as ‘No Gender’, If he does not belongs 
to any department the it should come as ‘No Department‘.*/

select * from Department1
select * from Gender
select * from Employee1

select E1.Name as EName,
	COALESCE(G1.Name,'NO Gender')as GName,
	COALESCE(D1.Name,'NO Department')as DName
from
	Department1 D1 
right join
	Employee1 E1 on D1.Id = E1.DId
left join
	Gender G1 on E1.GenderId = G1.Id
/*	EName	DName		DName
	Ashish	male		Admin
	Ritesh	male		NO Department
	Jyoti	Female		IT
	Dheeraj	male		IT
	Satish	NO Gender	IT
	Archana	Female		IT*/


select * from Department1
select * from Gender
select * from Employee1

--2.Retrieve all employee count by their Gender.	
Select G1.Name as Gender,count(E1.GenderId)as Gender_count
from 
	Employee1 E1 join Gender G1
	on E1.GenderId = G1.Id
group by G1.Name
/*
Gender	Gender_count
Female		2
male		3*/

--3.Retrieve all employee count by their Department.
select D1.name as Department_Name,
		Count(E1.DId) As Employee_Count
from 
	Employee1 E1 right join Department1 D1
	on E1.DId = D1.Id
	group by D1.Name
/*Department_Name	Employee_Count
	Admin				1
	HR					0
	IT					4*/

--4.Retrieve all employee count by their Gender and Department Both.
select G1.Name as Gender_Name,
		D1.Name as Department_Name,
		count(E1.Id)as Employee_count
from 
	Gender G1 
right join
	Employee1 E1 on G1.Id = E1.GenderId
left join
	Department1 D1 on  E1.DId = D1.Id 
Group by
	G1.Name,
	D1.Name
--right,Left join 
/*Gender_Name	Department_Name	Employee_count
	male			NULL			1
	male			Admin			1
	NULL			IT				1
	Female			IT				2
	male			IT				1*/
--Inner Join-output
/*Gender_Name	Department_Name	Employee_count
	male			Admin			1
	Female			IT				2
	male			IT				1*/
--Full Join
/*Gender_Name	Department_Name	Employee_count
	male		NULL			1
	Unknown		NULL			0
	male		Admin			1
	NULL		HR				0
	NULL		IT				1
	Female		IT				2
	male		IT				1*/


--5.Write a query to find max salary given to a male and female employee.
select G1.Name as Gender,MAX(Salary) as Max_Salary
from
	Gender G1
join
	Employee1 E1
	on G1.Id = E1.GenderId
group by 
	G1.Name
/*
Gender	Max_Salary
Female	9000
male	9500*/

select * from Department1
select * from Gender
select * from Employee1

--6.Write a query to find max salary given to a male and female employee by department.
select G1.Name as Gender_Name,
		D1.Name  as Department_Name,
		MAX(E1.Salary)as Max_salary
from 
	Gender G1
 join
	Employee1 E1 on G1.Id = E1.GenderId
join 
	Department1 D1 on E1.DId = D1.Id
Group by 
	G1.Name,
	D1.Name
/*
Gender_Name	Department_Name	Max_salary
	male		Admin		9000
	Female		IT			9000
	male		IT			5200*/
--Add Employee_Name
select E1.Name as Employee_Name,
		G1.Name as Gender_Name,
		D1.Name  as Department_Name,
		
		MAX(E1.Salary)as Max_salary
from 
	Gender G1
 join
	Employee1 E1 on G1.Id = E1.GenderId
 join 
	Department1 D1 on E1.DId = D1.Id
Group by 
	E1.Name,
	G1.Name,
	D1.Name
/*
Employee_Name	Gender_Name	Department_Name	Max_salary
Archana			Female			IT			9000
Ashish			male		   Admin		9000
Dheeraj			male			IT			5200
Jyoti			Female			IT			5000*/

--With Subquery
--7.Write a query to fetch 3rd highest salary. i.e. 5200. {do with 1. Subquey 2. Using CTE}

select Max(salary) as '3rd highest salary' from Employee1
Where salary <  
(Select max(salary) from Employee1
Where Salary <
(Select Max(Salary) from Employee1))

/*3rd highest salary
	5200*/

--With CTE
--7.Write a query to fetch 3rd highest salary. i.e. 5200. {do with 1. Subquey 2. Using CTE}
select Name,salary,rank()over(order by salary desc) as Third_Hightes_Salary
from Employee1

with CTE
as
(
select Name,salary,dense_rank()over(order by salary desc) as Third_Hightes_Salary
from Employee1
)
Select * from CTE where Third_Hightes_Salary = 3
/*
Name	salary	Third_Hightes_Salary
Dheeraj	5200		3
Satish	5200		3*/











select Name,Paidfees,rank()over(order by Paidfees desc)as SrNo
from Student

with cte
as
(
select Name ,paidfees,rank()over(order by paidfees desc) As SrNo
from student
)
select * from cte where SrNo=3




































