
CREATE DATABASE LibraryDB;
USE LibraryDB;


CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    book_title VARCHAR(100),
    author VARCHAR(50),
    copies_available INT
);


INSERT INTO books (book_title, author, copies_available) VALUES
('Math Basics', 'Priya Sharma', 5),
('Physics Fundamentals', 'Raj Verma', 2),
('Chemistry 101', 'Anil Kumar', 0),
('English Literature', 'Meena Rao', 3),
('History of India', 'Kiran Das', 4);


DELIMITER $$

CREATE PROCEDURE ListBooksByAuthor(IN author_name VARCHAR(50))
BEGIN
    SELECT book_id, book_title, copies_available,
           CASE 
               WHEN copies_available > 0 THEN 'Available'
               ELSE 'Not Available'
           END AS Status
    FROM books
    WHERE author = author_name;
END $$

DELIMITER ;


CALL ListBooksByAuthor('Priya Sharma');


DELIMITER $$

CREATE FUNCTION CalculateFine(overdue_days INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE fine DECIMAL(10,2);

    IF overdue_days <= 5 THEN
        SET fine = overdue_days * 2; -- Rs.2 per day
    ELSE
        SET fine = overdue_days * 5; -- Rs.5 per day after 5 days
    END IF;

    RETURN fine;
END $$

DELIMITER ;

SELECT book_title, copies_available,
       CalculateFine(3) AS Fine_For_3_Days,
       CalculateFine(7) AS Fine_For_7_Days
FROM books;
