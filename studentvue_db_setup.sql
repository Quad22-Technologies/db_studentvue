/*
Create Gradelist table and insert all grade level into it
*/

DROP TABLE IF EXISTS gradelevels CASCADE;
DROP TABLE IF EXISTS users CASCADE;
-- DROP TABLE IF EXISTS logins;
-- DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS classgrades CASCADE;
DROP TABLE IF EXISTS classnames CASCADE;

CREATE TABLE IF NOT EXISTS GradeLevels (
    id UUID PRIMARY KEY,
    abreviation VARCHAR(8) NOT NULL,
    name VARCHAR(16) NOT NULL
);

/*
Create joint Users table
*/

CREATE TABLE IF NOT EXISTS Users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    firstName VARCHAR(128) NOT NULL,
    lastName VARCHAR(128) NOT NULL,

    address VARCHAR(512),
    city VARCHAR(128),
    zipCode VARCHAR(6),
    state VARCHAR(32),

    gradelevels_id UUID,
    parent_id UUID,

    isTeacher BOOLEAN DEFAULT (false),
    isStudent BOOLEAN DEFAULT (false),
    isParent BOOLEAN DEFAULT (false),

    emailAddress VARCHAR(256) UNIQUE NOT NULL,
    username VARCHAR(128) UNIQUE NOT NULL,
    passwordHashed VARCHAR(512) NOT NULL,  -- hashed password using salt. bcrypt is good at hashing according to some sources
    salt INT DEFAULT random(),  -- salt used during hashing

    -- FOREIGN KEY (parent_id) REFERENCES Users(id), -- must be a valid gradelevel id
    FOREIGN KEY (gradelevels_id) REFERENCES GradeLevels(id) -- must be a valid gradelevel id
);

CREATE TABLE IF NOT EXISTS Classnames (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    name VARCHAR(128) NOT NULL,
    room_number VARCHAR(16),

    teacher_id UUID,

    FOREIGN KEY (teacher_id) REFERENCES Users(id)
);

CREATE TABLE IF NOT EXISTS Classgrades (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    student_id UUID,
    teacher_id UUID,
    classname_id UUID,
    
    grade FLOAT,
    
    FOREIGN KEY (student_id) REFERENCES Users(id),
    FOREIGN KEY (teacher_id) REFERENCES Users(id),
    FOREIGN KEY (classname_id) REFERENCES classnames(id)
);


/*
Create students table
*/

-- CREATE TABLE IF NOT EXISTS Students (
--     id UUID PRIMARY KEY,
--
--     users_ID UUID,
--     gradelevels_id UUID,
--     parent_id UUID,
--
--     FOREIGN KEY (users_ID) REFERENCES Users(id),  -- must be a valid gradelevel id
--     FOREIGN KEY (parent_id) REFERENCES Users(id), -- must be a valid gradelevel id
--     FOREIGN KEY (gradelevels_id) REFERENCES GradeLevels(id) -- must be a valid gradelevel id
-- );

/*
Create logins table
*/

-- Username can be gotten by querying the Users table
-- CREATE TABLE IF NOT EXISTS Logins (
--     id UUID PRIMARY KEY,
--
--
--
--     FOREIGN KEY (users_ID) REFERENCES Users(id)
-- );

/*
ClassNames
*/


 -- insert grade levels.
INSERT INTO GradeLevels (id, abreviation, name) VALUES
    ('afbe17f4d5d9408fabab98a8b71cc3c1', 'PreK', 'PreKindergarten'),
    ('09964330b83e455499a159542b013ff7', 'K',    'Kindergarten'),
    ('e608aa153cdb46b3b31926c196c4c850', '1',    '1st Grade'),
    ('cef71c3fca7846808a9f022952beaf01', '2',    '2nd Grade'),
    ('72b83074d53c4f3781054988d2bebb73', '3',    '3rd Grade'),
    ('d8e0727113e54654a6ffeb62a7310aee', '4',    '4th Grade'),
    ('55704a3fdf0a42a484f3a683e1c3cb30', '5',    '5th Grade'),
    ('2eeaf004b3254d30910917569f05a577', '6',    '6th Grade'),
    ('78724b3ab6f047329e511e7e0a25f297', '7',    '7th Grade'),
    ('6478b4a4e0b84f8ea458ab41c98a1adb', '8',    '8th Grade'),
    ('740b212bd7a04becadaee6b49386be1a', '9',    '9th Grade'),
    ('7c269b7029a74b889c01c17de93970af', '10',   '10th Grade'),
    ('25d3676ab2da475295ef55c8a225cce6', '11',   '11th Grade'),
    ('c7af00c7bff74a499fca6fbb2bc5b848', '12',   '12th Grade');

--  -- Insert example data
INSERT INTO users (id, firstname, lastname, address, city, zipcode, state, isteacher, isstudent, isparent, emailaddress, username, passwordhashed, salt, gradelevels_id) VALUES
    ('7e5e7e9f3856430a982c2b89dd11b443', 'Walter', 'White',    '308 Negra Arroyo Lane', 'Albequerque', 87111, 'New Mexico', true,  false, false, 'example1@gmail.com', 'WalterW',   'examplePswd', 6969, '740b212bd7a04becadaee6b49386be1a'),
    ('2646919e58874e70bee8fbcf5e33b5e8', 'Walter', 'White Jr', '308 Negra Arroyo Lane', 'Albequerque', 87111, 'New Mexico', false, true,  false, 'example2@gmail.com', 'WalterWJr', 'examplePswd', 6969, '740b212bd7a04becadaee6b49386be1a'),
    ('0dd6110ee79142b5943c0cbb2fc2f67b', 'Bob',    'Person',   '309 Negra Arroyo Lane', 'Albequerque', 87111, 'New Mexico', false, true,  false, 'example3@gmail.com', 'BobP',      'examplePswd', 6969, '740b212bd7a04becadaee6b49386be1a'),
    ('c18bae7516c04ecfbf3bba61708b05cf', 'Bill',   'Gibby',    '310 Negra Arroyo Lane', 'Albequerque', 87111, 'New Mexico', false, true,  false, 'example4@gmail.com', 'BillG',     'examplePswd', 6969, '740b212bd7a04becadaee6b49386be1a'),
    ('5120653215314b91bf40f393a704cacb', 'Sally',  'Austin',   '311 Negra Arroyo Lane', 'Albequerque', 87111, 'New Mexico', false, true,  false, 'example5@gmail.com', 'SallyA',    'examplePswd', 6969, '740b212bd7a04becadaee6b49386be1a'),
    ('a3841266b99a4d48add6e1e1d1cc97af', 'Jack',   'Burrows',  '311 Negra Arroyo Lane', 'Albequerque', 87111, 'New Mexico', false, false, true,  'example6@gmail.com', 'JackB',     'examplePswd', 6969, '740b212bd7a04becadaee6b49386be1a');

INSERT INTO classnames (id, name, room_number, teacher_id) VALUES
    ('6c7f3da1d8584c188c2b4ac71183ad28', 'Algebra IIH', '2345', '7e5e7e9f3856430a982c2b89dd11b443'),
    ('dd1d24499ce945e1b24edae18d5bb043', 'Chemistry IA', '1442', '7e5e7e9f3856430a982c2b89dd11b443');

INSERT INTO classgrades (student_id, teacher_id, classname_id, grade) VALUES
    ('2646919e58874e70bee8fbcf5e33b5e8', '7e5e7e9f3856430a982c2b89dd11b443', '6c7f3da1d8584c188c2b4ac71183ad28', 92.1),
    ('c18bae7516c04ecfbf3bba61708b05cf', '7e5e7e9f3856430a982c2b89dd11b443', '6c7f3da1d8584c188c2b4ac71183ad28', 99.1),
    ('0dd6110ee79142b5943c0cbb2fc2f67b', '7e5e7e9f3856430a982c2b89dd11b443', '6c7f3da1d8584c188c2b4ac71183ad28', 77.5);

-- INSERT INTO logins (id, users_id, username, passwordhashed, salt) VALUES
--     ('9900cf513cf44ea3b58b22b86e76b5ad', '7e5e7e9f3856430a982c2b89dd11b443', 'wwhite', 'SOMEHASHEDDATA', 6969),
--     ('224d1c2a39c44c6da85f7fc0386c5b2a', '2646919e58874e70bee8fbcf5e33b5e8', 'wwhitejr', 'SOMEHASHEDDATA', 1800),
--     ('afd87ba525b24e4c85e57f55b8f77ae8', '0dd6110ee79142b5943c0cbb2fc2f67b', 'bperson', 'SOMEHASHEDDATA', 8888),
--     ('631943150ba54ff8a1dda2c72dd989c5', 'c18bae7516c04ecfbf3bba61708b05cf', 'bgibby', 'SOMEHASHEDDATA', 25565),
--     ('ce7347db01db4f8e932d5fb6751370a9', '5120653215314b91bf40f393a704cacb', 'saustin', 'SOMEHASHEDDATA', 1234),
--     ('ce8621e0e0534da8b8ff328ebb46bb90', 'a3841266b99a4d48add6e1e1d1cc97af', 'jburrows', 'SOMEHASHEDDATA', 420);


-- INSERT INTO students (id, users_id, gradelevels_id) VALUES
--     ('c5af9c478d574a4384a28c0d47819e6b', '2646919e58874e70bee8fbcf5e33b5e8', 'c7af00c7bff74a499fca6fbb2bc5b848'),
--     ('4b7d12be39e940968e81fce654e5c7fa', '0dd6110ee79142b5943c0cbb2fc2f67b', 'c7af00c7bff74a499fca6fbb2bc5b848'),
--     ('a7aa2d04118b43b5ab9c33320d5cebd8', 'c18bae7516c04ecfbf3bba61708b05cf', 'c7af00c7bff74a499fca6fbb2bc5b848'),
--     ('07996863058a46a49b7819cc0926eb3a', '5120653215314b91bf40f393a704cacb', 'c7af00c7bff74a499fca6fbb2bc5b848');





 -- SELECT firstname, lastname, abreviation, gradelevels.name FROM users, students, gradelevels WHERE users.isstudent=true AND users.id = students.userid AND students.gradelevelid = gradelevels.id;
