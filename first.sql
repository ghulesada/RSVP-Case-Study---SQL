create database dummy;
use dummy;
/* TABLE CREATION SCRIPT - MySQL */
DROP TABLE emp_details;
CREATE TABLE emp_details
    (
        id           int PRIMARY KEY,
        name         varchar(100),
        manager_id   int,
        salary       int,
        designation  varchar(100)

    );

INSERT INTO emp_details VALUES (1,  'Shripadh', NULL, 10000, 'CEO');
INSERT INTO emp_details VALUES (2,  'Satya', 5, 1400, 'Software Engineer');
INSERT INTO emp_details VALUES (3,  'Jia', 5, 500, 'Data Analyst');
INSERT INTO emp_details VALUES (4,  'David', 5, 1800, 'Data Scientist');
INSERT INTO emp_details VALUES (5,  'Michael', 7, 3000, 'Manager');
INSERT INTO emp_details VALUES (6,  'Arvind', 7, 2400, 'Architect');
INSERT INTO emp_details VALUES (7,  'Asha', 1, 4200, 'CTO');
INSERT INTO emp_details VALUES (8,  'Maryam', 1, 3500, 'Manager');
INSERT INTO emp_details VALUES (9,  'Reshma', 8, 2000, 'Business Analyst');
INSERT INTO emp_details VALUES (10, 'Akshay', 8, 2500, 'Java Developer');
commit;

/* Q1: Display number from 1 to 10 without using any in built functions. */
with recursive num as
	(select 1 as n
    union
    select n+1 as n
    from num where n < 10
    )
select * from num;

/* Q2: Find the hierarchy of employees under a given manager */
with recursive managers as
	(select id as emp_id, name as emp_name, manager_id
	 , designation as emp_role, 1 as level
	 from emp_details e where id=7
	 union
	 select e.id as emp_id, e.name as emp_name, e.manager_id
	 , e.designation as emp_role, level+1 as level
	 from emp_details e
	 join managers m on m.emp_id = e.manager_id)
select *
from managers;

/* Q2-A: Find the hierarchy of employees under a given employee. Also displaying the manager name. */
with recursive managers as
	(select id as emp_id, name as emp_name, manager_id
	 , designation as emp_role, 1 as level
	 from emp_details e where id=7
	 union
	 select e.id as emp_id, e.name as emp_name, e.manager_id
	 , e.designation as emp_role, level+1 as level
	 from emp_details e
	 join managers m on m.emp_id = e.manager_id)
select m.emp_id, m.emp_name, m.manager_id, e.name as manager_name
, m.emp_role, m.level
from managers m
join emp_details e on e.id=m.manager_id;

/* Q3: Find the hierarchy of managers for a given employee */
with recursive managers as
	(select id as emp_id, name as emp_name, manager_id
	 , designation as emp_role, 1 as level
	 from emp_details e where id=7
	 union
	 select e.id as emp_id, e.name as emp_name, e.manager_id
	 , e.designation as emp_role, level+1 as level
	 from emp_details e
	 join managers m on m.manager_id = e.id)
select *
from managers;
