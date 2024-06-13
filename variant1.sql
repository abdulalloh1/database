CREATE TABLE Entrant (
    Id INT PRIMARY KEY,
    Name VARCHAR(50),
    Second_name VARCHAR(50),
    Last_name VARCHAR(50),
    Sex CHAR(1),
    Sert_id INT,
    Sert_school VARCHAR(100),
    Sert_date DATE,
    Pass_ser VARCHAR(10),
    Pass_number VARCHAR(10),
    Address VARCHAR(255)
);

CREATE TABLE Ent_sert (
    Id INT PRIMARY KEY,
    Name VARCHAR(50)
);

CREATE TABLE Subject (
    Id INT PRIMARY KEY,
    Name VARCHAR(50),
    Our_subject VARCHAR(50),
    School_subject VARCHAR(50)
);

CREATE TABLE School_mark (
    Subject_id INT,
    Entrant_id INT,
    Mark INT,
    FOREIGN KEY (Subject_id) REFERENCES Subject(Id),
    FOREIGN KEY (Entrant_id) REFERENCES Entrant(Id)
);

CREATE TABLE Exam (
    Id INT PRIMARY KEY,
    Subj_id INT,
    Exam_date DATE,
    Exforma_id INT,
    Department VARCHAR(100),
    FOREIGN KEY (Subj_id) REFERENCES Subject(Id)
);

CREATE TABLE Mark (
    Exam_id INT,
    Entrant_id INT,
    Mark INT,
    User_name VARCHAR(50),
    Change_date DATE,
    FOREIGN KEY (Exam_id) REFERENCES Exam(Id),
    FOREIGN KEY (Entrant_id) REFERENCES Entrant(Id)
);


CREATE TABLE Exam_forma (
    Id INT PRIMARY KEY,
    Name VARCHAR(50)
);

-- Заполнение базы данными
INSERT INTO Entrant (Id, Name, Second_name, Last_name, Sex, Sert_id, Sert_school, Sert_date, Pass_ser, Pass_number, Address)
VALUES
(1, 'Александр', 'Иванович', 'Смирнов', 'М', 101, 'Школа №1', '2021-06-20', '4500', '123456', 'г. Москва, ул. Ленина, д.10'),
(2, 'Мария', 'Петровна', 'Иванова', 'Ж', 102, 'Школа №2', '2021-06-21', '4501', '123457', 'г. Москва, ул. Мира, д.20'),
(3, 'Александра', 'Сергеевна', 'Петрова', 'Ж', 103, 'Школа №3', '2021-06-22', '4502', '123458', 'г. Москва, ул. Пушкина, д.30'),
(4, 'Иван', 'Алексеевич', 'Кузнецов', 'М', 104, 'Школа №4', '2021-06-23', '4503', '123459', 'г. Москва, ул. Космонавтов, д.40'),
(5, 'Александр ', '   Дмитриевич', 'Воробьев', 'М', 105, 'Школа №5', '2021-06-24', '4504', '123450', 'г. Москва, ул. Чкалова, д.50');

INSERT INTO Ent_sert (Id, Name)
VALUES
(101, 'Аттестат за 11 класс'),
(102, 'Аттестат за 11 класс'),
(103, 'Аттестат за 11 класс'),
(104, 'Аттестат за 11 класс'),
(105, 'Аттестат за 11 класс');

INSERT INTO Subject (Id, Name, Our_subject, School_subject)
VALUES
(1, 'Математика', 'Вузовский предмет', 'Школьный предмет'),
(2, 'Физика', 'Вузовский предмет', 'Школьный предмет'),
(3, 'Химия', 'Вузовский предмет', 'Школьный предмет');

INSERT INTO School_mark (Subject_id, Entrant_id, Mark)
VALUES
(1, 1, 5),
(1, 2, 2),
(1, 3, 4),
(1, 4, 5),
(1, 5, 5);

INSERT INTO Mark (Exam_id, Entrant_id, Mark, User_name, Change_date)
VALUES
(1, 1, 5, 'admin', '2023-05-01'),
(1, 2, 2, 'admin', '2023-05-01'),
(1, 3, 4, 'admin', '2023-05-01'),
(1, 4, 5, 'admin', '2023-05-01'),
(1, 5, 5, 'admin', '2023-05-01');

INSERT INTO Exam (Id, Subj_id, Exam_date, Exforma_id, Department)
VALUES
(1, 1, '2023-06-01', 1, 'Мехмат'),
(2, 2, '2023-06-02', 1, 'Физико-математический факультет');
	
-- SQL запросы для выполнения

-- SQL запрос для выполнения 1 задания
SELECT DISTINCT Name 
FROM Subject 
WHERE Our_subject = 'Вузовский предмет';


-- SQL запрос для выполнения 2 задания
SELECT e.Last_name, m.Mark
FROM Entrant e
JOIN Mark m ON e.Id = m.Entrant_id;

-- SQL запрос для выполнения 3 задания
SELECT e.Last_name, e.Name, e.Second_name
FROM Entrant e
JOIN School_mark sm ON e.Id = sm.Entrant_id
JOIN Subject s ON sm.Subject_id = s.Id
WHERE s.Name = 'Математика' AND sm.Mark > 3;

-- SQL запрос для выполнения 4 задания
SELECT e.Last_name || ' ' || LEFT(e.Name, 1) || '.' || LEFT(e.Second_name, 1) || '.' AS FullName, m.Mark
FROM Entrant e
JOIN Mark m ON e.Id = m.Entrant_id
JOIN Exam ex ON m.Exam_id = ex.Id
JOIN Subject s ON ex.Subj_id = s.Id
WHERE s.Name = 'Математика' AND ex.Department = 'Мехмат'
ORDER BY m.Mark DESC;

-- SQL запрос для выполнения 5 задания
SELECT Id, Last_name, Name, Second_name 
FROM Entrant 
WHERE Id NOT IN (SELECT DISTINCT Entrant_id FROM Mark);

-- SQL запрос для выполнения 6 задания
SELECT Last_name, Name, Id 
FROM Entrant
WHERE LTRIM(RTRIM(Name)) LIKE 'Александр%';

-- SQL запрос для выполнения 7 задания
DELETE FROM Entrant
WHERE Id IN (
    SELECT e.Id
    FROM Entrant e
    JOIN School_mark sm ON e.Id = sm.Entrant_id
    JOIN Subject s ON sm.Subject_id = s.Id
    WHERE s.Name = 'Математика' AND sm.Mark = 2
);

-- SQL запрос для выполнения 8 задания
INSERT INTO Entrant (Id, Name, Second_name, Last_name, Sex, Sert_id, Sert_school, Sert_date, Pass_ser, Pass_number, Address)
VALUES
(6, 'Елена', 'Викторовна', 'Николаева', 'Ж', 106, 'Гимназия №6', '2021-06-25', '4505', '123461', 'г. Москва, ул. Октябрьская, д.60');
