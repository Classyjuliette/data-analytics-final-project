create database employee_dataset;
show tables;
Rename table employee_dataset to employees;
show columns from employees;

select distinct job_title from employees;
select distinct education_level from employees;
select distinct industry from employees;

Select avg(salary) from employees;
Select sum(salary) from employees;

create table employees_log (
log_id int auto_increment primary key,
action_type varchar (20),
action_date datetime );

DELIMITER //
CREATE TRIGGER trg_insert_employee
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO
employees_log(action_type, action_date)
    VALUES ( 'INSERT', NOW());
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_update_employee
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO
employees_log(action_type, action_date)
	VALUES ('UPDATE', NOW());
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_delete_employee
AFTER DELETE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO
employees_log(action_type, action_date)
	VALUES ('DELETE', NOW());
END //
DELIMITER ;

show triggers;

DELIMITER //
CREATE PROCEDURE
GetHighSalaryEmployees(IN min_salary INT)
BEGIN
SELECT *
FROM employees
WHERE salary > min_salary;
END //

CALL GetHighSalaryEmployees(150000);

ALTER TABLE employees
ADD age INT;
select * from employees;

ALTER TABLE employees
RENAME COLUMN certifications TO certification_count;
select * from employees;

create user 'project_user '@' localhost'
identified by 'password1395';

GRANT SELECT, INSERT, ALTER 
ON employees_database.*
TO 'project_user'@'localhost';

FLUSH PRIVILEGES;

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

CREATE TABLE personnel (
    personnel_id INT PRIMARY KEY,
    personnel_name VARCHAR(50),
    department_id INT,
    FOREIGN KEY (department_id)
    REFERENCES
departments(department_id));

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50),
    personnel_id INT,
    FOREIGN KEY (personnel_id)
    REFERENCES
personnel(personnel_id));

Insert into departments
values (1, 'IT'),
	   (2, 'HR'),
       (3, 'FINANCE');
       
Insert into personnel
values (101, 'John', 1),
	   (102, 'Juliet', 2),
       (103, 'Patrick', 3);
       
Insert into projects
values (201, 'Payroll system', 101),
	   (202, 'Recruitment portal', 102),
       (203, 'Assembling', 103);

SELECT p.personnel_name, 
d.department_name 
FROM personnel p
INNER JOIN departments d
ON p.department_id = d.department_id;       

SELECT p.personnel_name, 
d.department_name 
FROM personnel p
LEFT JOIN departments d
ON p.department_id = d.department_id;

SELECT p.personnel_name, 
d.department_name 
FROM personnel p
RIGHT JOIN departments d
ON p.department_id = d.department_id;
















