CREATE TABLE Entrant (
    Id INT PRIMARY KEY,
    Name VARCHAR(50),
    Second_name VARCHAR(50),
    Last_name VARCHAR(50),
    Sex VARCHAR(10),
    Sert_id INT,
    Sert_school VARCHAR(100),
    Sert_date DATE,
    Pass_ser VARCHAR(10),
    Pass_number VARCHAR(20),
    Address VARCHAR(100)
);

CREATE TABLE Education_Documents (
    Code INT PRIMARY KEY,
    Name VARCHAR(100)
);

CREATE TABLE Subjects (
    Code INT PRIMARY KEY,
    Name VARCHAR(100),
    School_subject VARCHAR(100),
    University_subject VARCHAR(100)
);

CREATE TABLE School_Marks (
    Subject_id INT,
    Entrant_id INT,
    Mark INT,
    FOREIGN KEY (Subject_id) REFERENCES Subjects(Code),
    FOREIGN KEY (Entrant_id) REFERENCES Entrant(Id)
);

CREATE TABLE Exam_Marks (
    Exam_id INT,
    Entrant_id INT,
    Mark INT,
    User_name VARCHAR(50),
    Change_date DATE,
    FOREIGN KEY (Entrant_id) REFERENCES Entrant(Id)
);

CREATE TABLE Exams (
    Exam_id INT PRIMARY KEY,
    Subject_id INT,
    Exam_date DATE,
    Exform_id INT,
    Department VARCHAR(100),
    FOREIGN KEY (Subject_id) REFERENCES Subjects(Code)
);

CREATE TABLE Exam_Forms (
    Exform_id INT PRIMARY KEY,
    Name VARCHAR(100)
);

-- Данные для заполнения базы данными 

INSERT INTO Education_Documents (Code, Name)
VALUES
    (1, 'Certificate of Secondary Education'),
    (2, 'High School Diploma'),
    (3, 'Certificate of Basic Education');


INSERT INTO Subjects (Code, Name, School_subject, University_subject)
VALUES
    (1, 'Mathematics', 'Mathematics', 'Mathematics'),
    (2, 'Russian Language', 'Russian Language', 'Russian Language'),
    (3, 'Physics', 'Physics', 'Physics'),
    (4, 'Informatics', 'Informatics', 'Informatics');


INSERT INTO Exam_Forms (Exform_id, Name)
VALUES
    (1, 'Entrance Exam'),
    (2, 'Test'),
    (3, 'Interview');


INSERT INTO Entrant (Id, Name, Second_name, Last_name, Sex, Sert_id, Sert_school, Sert_date, Pass_ser, Pass_number, Address)
VALUES
    (1, 'John', 'Doe', 'Smith', 'M', 1, 'School #1', '2000-05-15', '1234', '567890', 'Moscow, Pushkin St., 10'),
    (2, 'Jane', 'Doe', 'Doe', 'F', 2, 'Gymnasium #2', '1999-12-20', '4321', '098765', 'Saint Petersburg, Lermontov St., 5');


INSERT INTO School_Marks (Subject_id, Entrant_id, Mark)
VALUES
    (1, 1, 90),
    (2, 1, 85),
    (3, 1, 80),
    (4, 1, 88),
    (1, 2, 92),
    (2, 2, 87),
    (3, 2, 82),
    (4, 2, 90);


INSERT INTO Exams (Exam_id, Subject_id, Exam_date, Exform_id, Department)
VALUES
    (1, 1, '2024-06-10', 1, 'Mathematics Department'),
    (2, 2, '2024-06-12', 1, 'Philology Department');


INSERT INTO Exam_Marks (Exam_id, Entrant_id, Mark, User_name, Change_date)
VALUES
    (1, 1, 85, 'admin', '2024-06-11'),
    (2, 1, 90, 'admin', '2024-06-13'),
    (1, 2, 88, 'admin', '2024-06-11'),
    (2, 2, 92, 'admin', '2024-06-13');
	

-- SQL запросы 

-- SQL запрос по 1 вопросу
SELECT COUNT(*) AS Total_Exams
FROM Exams;

-- SQL зпарос по 2 вопросу 
SELECT e.Department, AVG(em.Mark) AS Average_Math_Mark
FROM Exams e
JOIN Exam_Marks em ON e.Exam_id = em.Exam_id
JOIN Subjects s ON e.Subject_id = s.Code
WHERE s.Name = 'Mathematics'
GROUP BY e.Department;

-- SQL зпарос по 3 вопросу
SELECT e.Department
FROM Exams e
JOIN Exam_Marks em ON e.Exam_id = em.Exam_id
GROUP BY e.Department
HAVING AVG(em.Mark) > 4;

-- SQL зпарос по 4 вопросу
SELECT e.Department, em.Mark
FROM Exams e
JOIN Exam_Marks em ON e.Exam_id = em.Exam_id
JOIN Subjects s ON e.Subject_id = s.Code;

-- SQL зпарос по 5 вопросу
SELECT DISTINCT em.Entrant_id
FROM Exam_Marks em
JOIN Exams e ON em.Exam_id = e.Exam_id
WHERE em.Mark > 2
AND e.Subject_id IN (1, 2, 3);


-- SQL зпарос по 6 вопросу
WITH Total_Exams AS (
    SELECT COUNT(DISTINCT Exam_id) AS Total_Exam_Count
    FROM Exams
),
Passed_Exams AS (
    SELECT em.Entrant_id, COUNT(DISTINCT em.Exam_id) AS Passed_Exam_Count
    FROM Exam_Marks em
    JOIN Exams e ON em.Exam_id = e.Exam_id
    GROUP BY em.Entrant_id
)
SELECT pe.Entrant_id
FROM Passed_Exams pe
JOIN Total_Exams te ON pe.Passed_Exam_Count = te.Total_Exam_Count;


-- SQL зпарос по 7 вопросу
SELECT em.Entrant_id
FROM Exam_Marks em
JOIN Exams e ON em.Exam_id = e.Exam_id
JOIN Subjects s ON e.Subject_id = s.Code
WHERE em.Mark = 5
GROUP BY em.Entrant_id
HAVING COUNT(DISTINCT e.Department) > 1;





