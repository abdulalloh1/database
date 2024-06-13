-- Создание таблицы сотрудников
CREATE TABLE Employees (
    Employee_id INT PRIMARY KEY,
    First_name VARCHAR(50),
    Last_name VARCHAR(50),
    Email VARCHAR(100),
    Phone_number VARCHAR(15),
    Hired_date DATE,
    Job_id INT,
    Salary DECIMAL(10, 2),
    Commission_pct DECIMAL(5, 2),
    Manager_id INT,
    Department_id INT
);

-- Создание таблицы работ
CREATE TABLE Jobs (
    Job_id INT PRIMARY KEY,
    Job_title VARCHAR(100),
    Min_salary DECIMAL(10, 2),
    Max_salary DECIMAL(10, 2)
);

-- Создание таблицы отделов
CREATE TABLE Departments (
    Department_id INT PRIMARY KEY,
    Department_name VARCHAR(100),
    Manager_id INT,
    Location_id INT
);

-- Создание таблицы местоположений
CREATE TABLE Locations (
    Location_id INT PRIMARY KEY,
    Street_address VARCHAR(100),
    Postal_code VARCHAR(20),
    City VARCHAR(50),
    State_province VARCHAR(50),
    Country_id CHAR(2)
);

-- Создание таблицы стран
CREATE TABLE Countries (
    Country_id CHAR(2) PRIMARY KEY,
    Country_name VARCHAR(50),
    Region_id INT
);

-- Создание таблицы регионов
CREATE TABLE Regions (
    Region_id INT PRIMARY KEY,
    Region_name VARCHAR(50)
);

-- Заполнение базы данными
INSERT INTO Regions (Region_id, Region_name) VALUES (1, 'Europe'), (2, 'North America');

INSERT INTO Countries (Country_id, Country_name, Region_id) VALUES ('FR', 'France', 1), ('US', 'United States', 2);

INSERT INTO Locations (Location_id, Street_address, Postal_code, City, State_province, Country_id)
VALUES (1, '123 Boulevard', '75001', 'Paris', 'Paris', 'FR'), (2, '321 Ave', '10001', 'New York', 'NY', 'US');

INSERT INTO Departments (Department_id, Department_name, Manager_id, Location_id)
VALUES (20, 'IT', 1, 1), (30, 'Finance', 2, 1), (50, 'HR', 3, 2);

INSERT INTO Employees (Employee_id, First_name, Last_name, Email, Phone_number, Hired_date, Job_id, Salary, Commission_pct, Manager_id, Department_id)
VALUES 
(1, 'David', 'Smith', 'd.smith@company.com', '555-1010', '2018-01-10', 1, 5000.00, 0.10, NULL, 50),
(2, 'John', 'Doe', 'j.doe@company.com', '555-1011', '2019-02-20', 2, 4500.00, 0.15, 1, 50),
(3, 'Anna', 'Johnson', 'a.johnson@company.com', '555-1012', '2020-03-15', 1, 4200.00, 0.20, 1, 20),
(4, 'David', 'Lee', 'd.lee@company.com', '555-1013', '2021-04-10', 2, 3900.00, 0.12, 2, 30);

-- SQL запросы

-- SQL запрос для выполнения 1 - задания
SELECT * FROM Employees WHERE First_name = 'David';

-- SQL запрос для выполнения 2 - задания
SELECT * FROM Employees WHERE Department_id = 50 AND Salary > 4000;

-- SQL запрос для выполнения 3 - задания
SELECT * FROM Employees WHERE Department_id IN (20, 30);

-- SQL запрос для выполнения 4 - задания
SELECT * FROM Employees WHERE First_name LIKE '%a';

-- SQL запрос для выполнения 5 - задания
SELECT Department_id, COUNT(*) AS Employee_Count FROM Employees GROUP BY Department_id;

-- SQL запрос для выполнения 6 - задания
SELECT e.* FROM Employees e
JOIN Departments d ON e.Department_id = d.Department_id
JOIN Locations l ON d.Location_id = l.Location_id
JOIN Countries c ON l.Country_id = c.Country_id
JOIN Regions r ON c.Region_id = r.Region_id
WHERE r.Region_name = 'Europe';

-- SQL запрос для выполнения 7 - задания
SELECT Department_id, COUNT(*) AS Employee_Count
FROM Employees
GROUP BY Department_id
HAVING COUNT(*) > 30;

-- SQL запрос для выполнения 8 - задания
-- Добавление нового отдела
INSERT INTO Departments (Department_id, Department_name, Manager_id, Location_id) VALUES (60, 'Marketing', 4, 2);

-- Добавление нового сотрудника
INSERT INTO Employees (Employee_id, First_name, Last_name, Email, Phone_number, Hired_date, Job_id, Salary, Commission_pct, Manager_id, Department_id)
VALUES (5, 'Emily', 'Rogers', 'e.rogers@company.com', '555-1014', '2022-05-01', 3, 4300.00, 0.10, 4, 60);
