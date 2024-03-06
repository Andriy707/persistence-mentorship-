CREATE SEQUENCE IF NOT EXISTS seq_address_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE;

CREATE SEQUENCE IF NOT EXISTS seq_person_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE;

CREATE SEQUENCE IF NOT EXISTS seq_department_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE;

CREATE SEQUENCE IF NOT EXISTS seq_course_id
    START WITH 1
    INCREMENT BY 50;

CREATE SEQUENCE IF NOT EXISTS seq_student_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE;

CREATE SEQUENCE IF NOT EXISTS seq_teacher_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE;


CREATE SEQUENCE IF NOT EXISTS seq_assignments_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE;

CREATE SEQUENCE IF NOT EXISTS seq_book_id
    START WITH 1
    INCREMENT BY 50;


CREATE SEQUENCE IF NOT EXISTS seq_library_id
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE;



CREATE TABLE IF NOT EXISTS Address
(
    id      BIGINT DEFAULT nextval('seq_address_id'),
    street  VARCHAR(255),
    city    VARCHAR(255),
    zipCode VARCHAR(10),
    CONSTRAINT pk_address_id PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Person
(
    id           BIGINT DEFAULT nextval('seq_person_id'),
    name         VARCHAR(255),
    email        VARCHAR(255) UNIQUE,
    phone_number VARCHAR(15),
    DateOfBirth  DATE,
    CONSTRAINT pk_person_id PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Department
(
    id               BIGINT DEFAULT nextval('seq_department_id'),
    name             VARCHAR(255),
    headOfDepartment BIGINT,
    CONSTRAINT pk_department_id PRIMARY KEY (id),
    CONSTRAINT fk_headOfDepartment_id FOREIGN KEY (headOfDepartment) REFERENCES Person (id)
);

CREATE TABLE IF NOT EXISTS Course
(
    id              BIGINT DEFAULT nextval('seq_course_id'),
    name            VARCHAR(255),
    assignedTeacher BIGINT,
    created_at  DATE NOT NULL DEFAULT now(),
    FOREIGN KEY (assignedTeacher) REFERENCES Person (id),
    CONSTRAINT pk_course_id PRIMARY KEY (id)

);

---diff between now and current time stamp + DATE vs TIME stamp

CREATE TABLE IF NOT EXISTS Student
(
    id BIGINT DEFAULT nextval('seq_student_id'),
    CONSTRAINT fk_person_id FOREIGN KEY (id) REFERENCES Person (id),
    CONSTRAINT pk_student_id PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Teacher
(
    id BIGINT DEFAULT nextval('seq_teacher_id'),
    CONSTRAINT fk_teacher_id FOREIGN KEY (id) REFERENCES Person (id),
    CONSTRAINT pk_teacher_id PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Assignments
(
    id          BIGINT DEFAULT nextval('seq_assignments_id'),
    description TEXT,
    dueDate     DATE,
    CONSTRAINT pk_assigment_id PRIMARY KEY (id)

);

CREATE TABLE IF NOT EXISTS Book
(
    id              BIGINT DEFAULT nextval('seq_book_id'),
    title           VARCHAR(255),
    author          VARCHAR(255),
    availableCopies INT,
    CONSTRAINT pk_book_id PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Library
(
    id          BIGINT DEFAULT nextval('seq_library_id'),
    name        VARCHAR(255),
    address     BIGINT,
    director_id BIGINT,
    CONSTRAINT fk_library_id FOREIGN KEY (address) REFERENCES Address (id),
    CONSTRAINT pk_library_id PRIMARY KEY (id)
);
-- adding roles + employees

-- CREATE TABLE Role
-- (
--     id              INT PRIMARY KEY IDENTITY,
--     RoleName        NVARCHAR(100),
--     RoleDescription NVARCHAR(1000)
-- );

-- CREATE TABLE IF NOT EXISTS Employee
-- (
--     id      BIGINT,
--     role_id INT,
--     CONSTRAINT fk_employee FOREIGN KEY (id) REFERENCES Person (id),
-- --     CONSTRAINT fk_role FOREIGN KEY (role_id) REFERENCES Role (id),
--     CONSTRAINT pk_employee_id PRIMARY KEY (id)
-- );


-- ALTER TABLE Library
--     ADD CONSTRAINT fk_director_id FOREIGN KEY (director_id) REFERENCES Employee (id);


CREATE TABLE IF NOT EXISTS Student_Course
(
    student_id BIGINT,
    course_id  BIGINT,
    CONSTRAINT pk_student_course_ids PRIMARY KEY (student_id, course_id),
    CONSTRAINT fk_student_id FOREIGN KEY (student_id) REFERENCES Student (id),
    CONSTRAINT fk_course_id FOREIGN KEY (course_id) REFERENCES Course (id)
);

CREATE TABLE IF NOT EXISTS Teacher_Course
(
    teacher_id BIGINT NOT NULL,
    course_id  BIGINT NOT NULL,
    CONSTRAINT pk_teacher_course_ids PRIMARY KEY (teacher_id, course_id),
    CONSTRAINT fk_teacher_id FOREIGN KEY (teacher_id) REFERENCES Teacher (id),
    CONSTRAINT fk_course_id FOREIGN KEY (course_id) REFERENCES Course (id)
);

CREATE TABLE IF NOT EXISTS Library_Book
(
    library_id BIGINT NOT NULL,
    book_id    BIGINT NOT NULL,
    CONSTRAINT pk_library_book_ids PRIMARY KEY (library_id, book_id),
    CONSTRAINT fk_library_id FOREIGN KEY (library_id) REFERENCES Library (id),
    CONSTRAINT fk_book_id FOREIGN KEY (book_id) REFERENCES Book (id)
);

CREATE TABLE IF NOT EXISTS Course_Assignment
(
    course_id     BIGINT NOT NULL,
    assignment_id BIGINT NOT NULL,
    CONSTRAINT pk_course_assigment_ids PRIMARY KEY (course_id, assignment_id),
    CONSTRAINT fk_course_id FOREIGN KEY (course_id) REFERENCES Course (id),
    CONSTRAINT fk_assigment_id FOREIGN KEY (assignment_id) REFERENCES Assignments (id)
);




