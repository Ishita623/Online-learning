CREATE DATABASE Online_Learning;

USE Online_Learning;

CREATE TABLE Students ( student_id INT PRIMARY KEY , name VARCHAR(100),
email VARCHAR(100) UNIQUE, country VARCHAR(50),signup_date DATE );

INSERT INTO Students ( student_id ,name, email, country, signup_date) VALUES
(1,'Aarav Sharma', 'aarav@gmail.com', 'India', '2025-01-10'),
(2,'Priya Mehta', 'priya@gmail.com', 'India', '2025-01-15'),
(3,'Rahul Verma', 'rahul@gmail.com', 'India', '2025-02-01'),
(4,'Emily Johnson', 'emily@gmail.com', 'USA', '2025-02-10'),
(5,'Sophia Brown', 'sophia@gmail.com', 'UK', '2025-03-05'),
(6,'Daniel Lee', 'daniel@gmail.com', 'Canada', '2025-03-12'),
(7,'Neha Patil', 'neha@gmail.com', 'India', '2025-04-01'),
(8,'Karan Joshi', 'karan@gmail.com', 'India', '2025-04-08'),
(9,'Aditya Rao', 'aditya@gmail.com', 'India', '2025-02-10'),
(10,'Pooja Desai', 'pooja@gmail.com', 'India', '2025-03-05');

SELECT*FROM students;

CREATE TABLE Instructors (instructor_id INT PRIMARY KEY, name VARCHAR(100),
bio TEXT, expertise VARCHAR(100) );

INSERT INTO instructors (instructor_id,name, bio, expertise)
VALUES
(1,'Dr. Amit Joshi', 'Expert in Data Science', 'Data Science'),
(2,'Meera Kulkarni', 'Data Analyst Trainer', 'Data Analyst'),
(3,'Sanjay Gupta', 'Cloud Computing Specialist', 'Cloud Computing'),
(4,'Ritika Sharma', 'Digital Marketing Mentor', 'Marketing'),
(5,'Vikas Rao', 'Cyber Security Expert', 'Cyber Security'),
(6,'Ankit Verma', 'AI and Machine Learning Trainer', 'Artificial Intelligence'),
(7,'Shreya Iyer', 'UI/UX Design Specialist', 'UI/UX Design'),
(8,'Mohit Agarwal', 'Blockchain Technology Expert', 'Blockchain'),
(9,'Nisha Bansal', 'Business Analytics Mentor', 'Business Analytics'),
(10,'Arjun Deshmukh', 'DevOps and Automation Engineer', 'DevOps');

SELECT*FROM Instructors;

CREATE TABLE courses (course_id INT PRIMARY KEY ,course_title VARCHAR(150),instructor_id INT,
    category VARCHAR(100),price DECIMAL(10,2),
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id));
    
INSERT INTO courses (course_id, course_title, instructor_id, category, price)
VALUES
(1, 'SQL for Beginners', 1, 'Database', 1999.00),
(2, 'Python Programming', 1, 'Programming', 2999.00),
(3, 'Data Analyst', 2, 'Data Analyst', 4999.00),
(4, 'AWS Cloud Fundamentals', 3, 'Cloud Computing', 3999.00),
(5, 'Digital Marketing Masterclass', 4, 'Marketing', 2499.00),
(6, 'Ethical Hacking Basics', 5, 'Cyber Security', 3499.00),
(7, 'Advanced SQL', 1, 'Database', 2999.00),
(8, 'Data Analyst', 2, 'Data Analyst', 4500.00),
(9, 'Machine Learning Intro', 1, 'Data Science', 5500.00),
(10, 'SEO Optimization Course', 4, 'Marketing', 1999.00);

SELECT*FROM courses;

CREATE TABLE Enrollments (enrollment_id INT PRIMARY KEY ,student_id INT,course_id INT,
    enrollment_date DATE,completion_date DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id));

INSERT INTO Enrollments 
(enrollment_id, student_id, course_id, enrollment_date, completion_date)
VALUES
(1, 1, 1, '2025-03-01', '2025-03-20'),
(2, 1, 2, '2025-03-05', NULL),
(3, 2, 3, '2025-03-06', '2025-04-01'),
(4, 2, 5, '2025-03-10', NULL),
(5, 3, 1, '2025-03-12', '2025-03-30'),
(6, 3, 4, '2025-03-15', NULL),
(7, 4, 2, '2025-03-18', NULL),
(8, 4, 6, '2025-03-20', NULL),
(9, 5, 7, '2025-03-22', '2025-04-15'),
(10, 5, 8, '2025-03-25', NULL);

SELECT*FROM Enrollments;

CREATE TABLE modules (module_id INT PRIMARY KEY,course_id INT,
    module_title VARCHAR(150),sequence_number INT,
    FOREIGN KEY (course_id) REFERENCES courses(course_id));
    
   INSERT INTO modules (module_id, course_id, module_title, sequence_number)
VALUES
(1, 1, 'Introduction to SQL', 1),
(2, 1, 'SQL Queries and Joins', 2),
(3, 2, 'Python Basics', 1),
(4, 2, 'Functions and Loops in Python', 2),
(5, 3, 'Introduction to Data Analytics', 1),
(6, 3, 'Data Visualization Techniques', 2),
(7, 4, 'AWS Cloud Introduction', 1),
(8, 5, 'Digital Marketing Fundamentals', 1),
(9, 6, 'Basics of Ethical Hacking', 1),
(10, 9, 'Machine Learning Concepts', 1); 

SELECT*FROM modules;

CREATE TABLE quizzes (quiz_id INT PRIMARY KEY ,module_id INT,quiz_title VARCHAR(150),
    max_score INT,
    FOREIGN KEY (module_id) REFERENCES modules(module_id));
    
    INSERT INTO quizzes (quiz_id, module_id, quiz_title, max_score)
VALUES
(1, 1, 'SQL Introduction Quiz', 100),
(2, 2, 'SQL Joins Quiz', 100),
(3, 3, 'Python Basics Test', 100),
(4, 4, 'Python Functions Quiz', 100),
(5, 5, 'Data Analytics Fundamentals Quiz', 100),
(6, 6, 'Data Visualization Quiz', 100),
(7, 7, 'AWS Cloud Basics Quiz', 100),
(8, 8, 'Digital Marketing Quiz', 100),
(9, 9, 'Ethical Hacking Basics Test', 100),
(10, 10, 'Machine Learning Intro Quiz', 100);

SELECT*FROM Quizzes;

-- 1.List all courses a specific student is enrolled in.

    SELECT Students.name, 
    Courses.course_title 
    FROM Students 
    JOIN Enrollments ON Students.student_id = Enrollments.student_id
    JOIN Courses ON Enrollments.course_id = Courses.course_id 
    WHERE students.name = 'Aarav Sharma';

-- 2.Calculate the course completion rate

SELECT (COUNT(completion_date) * 100.0 / COUNT(*)) AS Completion_rate
FROM Enrollments;

-- 3.Find the instructor with the most courses

SELECT Instructors.name,COUNT(Courses.course_id) AS total_courses FROM Instructors 
JOIN Courses ON Instructors.instructor_id = Courses.instructor_id 
GROUP BY Instructors.name ORDER BY total_courses DESC LIMIT 1;

-- 4. Identify students who have enrolled in more than 5 courses

SELECT Students.name, COUNT(Enrollments.course_id) AS total_courses FROM Students
JOIN Enrollments ON Students.student_id = Enrollments.student_id 
GROUP BY Students.name HAVING COUNT(Enrollments.course_id) > 5;

-- 5. Calculate total revenue generated per course category

SELECT Courses.category,SUM(courses.price) AS total_revenue FROM Courses 
JOIN Enrollments ON courses.course_id = Enrollments.course_id
GROUP BY courses.category;

-- 6. List all modules for a specific course in sequence order

SELECT Courses.course_title,Modules.module_title,Modules.sequence_number FROM Courses 
JOIN Modules ON Courses.course_id = Modules.course_id
WHERE Courses.course_title = 'SQL for Beginners'
ORDER BY Modules.sequence_number;

-- 7. Find courses that have no enrolled students

SELECT Courses.course_title FROM Courses 
LEFT JOIN Enrollments ON Courses.course_id = Enrollments.course_id 
WHERE Enrollments.course_id IS NULL;

-- 8. Calculate average number of enrollments per course

SELECT AVG (total_enrollments) AS average_enrollments 
FROM ( SELECT course_id, COUNT(student_id) AS total_enrollments 
FROM Enrollments GROUP BY course_id) AS course_data;

-- 9. Identify the most popular course category

SELECT courses.category,COUNT(Enrollments.enrollment_id) AS total_enrollments 
FROM Courses 
JOIN Enrollments ON Courses.course_id = Enrollments.course_id 
GROUP BY Courses.category ORDER BY total_enrollments DESC LIMIT 1;

-- 10. Find students who have not completed any courses they enrolled in

SELECT Students.name FROM Students 
JOIN Enrollments ON Students.student_id = Enrollments.student_id
GROUP BY students.name HAVING COUNT(Enrollments.completion_date) = 0;

