CREATE TABLE Regions (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(100)
);

CREATE TABLE Countries (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(100),
    region_id INT REFERENCES Regions(region_id)
);

CREATE TABLE Locations (
    location_id INT PRIMARY KEY,
    street_address VARCHAR(100),
    postal_code VARCHAR(20),
    city VARCHAR(100),
    state_province VARCHAR(100),
    country_id INT REFERENCES Countries(country_id)
);

CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    manager_id INT,
    location_id INT REFERENCES Locations(location_id)
);

CREATE TABLE Jobs (
    job_id INT PRIMARY KEY,
    job_title VARCHAR(100),
    min_salary DECIMAL(10, 2),
    max_salary DECIMAL(10, 2)
);

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    hire_date DATE,
    job_id INT REFERENCES Jobs(job_id),
    salary DECIMAL(10, 2),
    commission_pct DECIMAL(5, 2),
    manager_id INT REFERENCES Employees(employee_id),
    department_id INT REFERENCES Departments(department_id)
);

-- Заполнение базы данными 
INSERT INTO Regions (region_id, region_name) VALUES
    (1, 'Europe'),
    (2, 'Asia'),
    (3, 'North America');

INSERT INTO Countries (country_id, country_name, region_id) VALUES
    (1, 'Germany', 1),
    (2, 'France', 1),
    (3, 'China', 2),
    (4, 'Japan', 2),
    (5, 'USA', 3),
    (6, 'Canada', 3);

INSERT INTO Locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES
    (1, '123 Main St', '12345', 'Berlin', 'Berlin', 1),
    (2, '456 Rue St', '54321', 'Paris', 'Ile de France', 2),
    (3, '789 Main St', '67890', 'Beijing', 'Beijing', 3),
    (4, '1011 Ginza St', '11122', 'Tokyo', 'Tokyo', 4),
    (5, '1315 Maple St', '33344', 'New York', 'NY', 5),
    (6, '1617 Maple St', '55566', 'Toronto', 'Ontario', 6);


INSERT INTO Departments (department_id, department_name, manager_id, location_id) VALUES
    (100, 'Sales', NULL, 1),
    (200, 'HR', NULL, 2),
    (300, 'IT', NULL, 3),
    (400, 'Marketing', NULL, 4);

INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES
    (1000, 'Manager', 50000.00, 100000.00),
    (2000, 'IT_PROG', 40000.00, 80000.00),
    (3000, 'HR Specialist', 35000.00, 70000.00);

INSERT INTO Employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES
    (1, 'John', 'Doe', 'john.doe@example.com', '123-456-7890', '1920-01-01', 1000, 8000, NULL, NULL, 100),
    (2, 'Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', '2020-02-15', 2000, 9000, 0.05, 1, 100),
    (3, 'Michael', 'Johnson', 'michael.johnson@example.com', '555-555-5555', '2020-03-01', 2000, 7000, 0.03, 1, 200),
    (4, 'Emily', 'Williams', 'emily.williams@example.com', '777-777-7777', '2020-04-01', 3000, 5500, NULL, 1, 300);


-- SQL запросы для выполнение заданний

-- SQL запрос для выполнение 1 задания
SELECT * FROM Employees;

-- SQL запрос для выполнение 2 задания
SELECT * FROM Employees WHERE job_id = (SELECT job_id FROM Jobs WHERE job_title = 'IT_PROG');

-- SQL запрос для выполнение 3 задания
SELECT * FROM Employees WHERE salary BETWEEN 8000 AND 9000;

-- SQL запрос для выполнение 4 задания
SELECT R.region_name, COUNT(E.employee_id) AS employee_count
FROM Regions R
LEFT JOIN Countries C ON R.region_id = C.region_id
LEFT JOIN Locations L ON C.country_id = L.country_id
LEFT JOIN Departments D ON L.location_id = D.location_id
LEFT JOIN Employees E ON D.department_id = E.department_id
GROUP BY R.region_name;

-- SQL запрос для выполнение 5 задания
SELECT EXTRACT(YEAR FROM hire_date) AS hire_year, COUNT(employee_id) AS employee_count
FROM Employees
GROUP BY EXTRACT(YEAR FROM hire_date)
ORDER BY employee_count DESC;

-- SQL запрос для выполнение 6 задания
SELECT D.department_id, D.department_name
FROM Departments D
LEFT JOIN Employees E ON D.department_id = E.department_id
WHERE E.employee_id IS NULL;

-- SQL запрос для выполнение 7 задания
SELECT E.first_name, J.job_title, D.department_name
FROM Employees E
JOIN Jobs J ON E.job_id = J.job_id
JOIN Departments D ON E.department_id = D.department_id;

-- SQL запрос для выполнение 8 задания
UPDATE Employees SET manager_id = NULL WHERE manager_id IN (SELECT employee_id FROM Employees WHERE DATE_PART('year', AGE(hire_date)) > 70);
DELETE FROM Employees WHERE DATE_PART('year', AGE(hire_date)) > 70;



