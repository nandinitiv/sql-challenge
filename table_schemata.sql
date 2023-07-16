DROP TABLE "Titles"
CREATE TABLE "Titles" (
    "title_id" varchar(6)   NOT NULL,
    "title" varchar(30)   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);

SELECT * FROM "Titles";

CREATE TABLE "Salary" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    CONSTRAINT "pk_Salary" PRIMARY KEY (
        "emp_no"
     )
);

SELECT * FROM "Salary" ORDER BY "emp_no";

drop table "Employees";

CREATE TABLE "Employees" (
    "emp_no" int   NOT NULL,
    "emp_title_id" varchar(6)   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(15)   NOT NULL,
    "last_name" varchar(20)   NOT NULL,
    "sex" varchar(2)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

Select * from "Employees";

Drop table "Dept_Manager";

CREATE TABLE "Dept_Manager" (
    "dept_no" varchar(6)   NOT NULL,
    "emp_no" int   NOT NULL,
    CONSTRAINT "pk_Dept_Manager" PRIMARY KEY (
        "emp_no", "dept_no"
     )
);

Select * from "Dept_Manager";

drop table "Dept_emp";

CREATE TABLE "Dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(6)   NOT NULL,
    CONSTRAINT "pk_Dept_emp" PRIMARY KEY (
        "emp_no", "dept_no"
     )
);

select * from "Dept_emp";

CREATE TABLE "Departments" (
    "dept_no" varchar(6)   NOT NULL,
    "dept_name" varchar(20)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

Select * from "Departments";

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Salary" ("emp_no");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "Titles" ("title_id");

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Dept_emp" ("emp_no");

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

-- Data Analysis 1. 
SELECT e.emp_no, e.first_name, e.last_name, e.sex, s.salary 
FROM "Employees" e
INNER JOIN "Salary" s ON e.emp_no = s.emp_no
ORDER BY e.emp_no;

-- Data Analysis 2. 
SELECT first_name, last_name, hire_date
FROM "Employees"
WHERE hire_date >= '1986-01-01' AND hire_date <= '1986-12-31';

-- Data Analysis 3. 
SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM "Dept_Manager" dm
INNER JOIN "Departments" d ON dm.dept_no = d.dept_no
INNER JOIN "Employees" e ON dm.emp_no = e.emp_no;

-- Data Analysis 4. 
SELECT e.emp_no, de.dept_no, d.dept_name, e.last_name, e.first_name
FROM "Employees" e
JOIN "Dept_emp" de ON e.emp_no = de.emp_no
JOIN "Departments" d ON de.dept_no = d.dept_no;

-- Data Analysis 5. 
SELECT e.first_name, e.last_name, e.sex FROM "Employees" e
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- Data Analysis 6.
SELECT e.emp_no, e.last_name, e.first_name 
FROM "Employees" e
JOIN "Dept_emp" de ON e.emp_no = de.emp_no
JOIN "Departments" d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

-- Data Analysis 7.
SELECT e.emp_no, e.last_name, e.first_name
FROM "Employees" e
JOIN "Dept_emp" de ON e.emp_no = de.emp_no
JOIN "Departments" d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development'; 

-- Data Analysis 8.
SELECT last_name, COUNT(*) AS frequency
FROM "Employees" 
GROUP BY last_name
ORDER BY frequency DESC;

