CREATE TABLE table_users (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    date_of_birth TEXT NOT NULL
);

CREATE TABLE table_phone_types (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    type TEXT NOT NULL
);

CREATE TABLE table_phones (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    phone_type_id INTEGER NOT NULL,
    phone_number TEXT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES table_users(id),
    FOREIGN KEY (phone_type_id) REFERENCES table_phone_types(id)
);

INSERT INTO table_users (first_name, last_name, date_of_birth) 
VALUES ('John', 'Doe', '1990-01-01'),
       ('Jane', 'Doe', '1995-05-10');

INSERT INTO table_phone_types (type) 
VALUES ('Home'),
       ('Work');

INSERT INTO table_phones (user_id, phone_type_id, phone_number) 
VALUES (1, 1, '123-456'),
       (1, 2, '789-012'),
       (2, 1, '345-678');

-- /************************************/
DROP VIEW IF EXISTS view_phones;
CREATE VIEW view_phones AS
SELECT table_phones.id AS id,
       table_users.first_name AS first_name,
       table_users.last_name AS last_name,
       table_users.date_of_birth AS date_of_birth,
       table_phone_types.type AS phone_type,
       table_phones.phone_number AS phone_number
FROM table_phones
    JOIN table_users 
        ON table_phones.user_id = table_users.id
    JOIN table_phone_types 
        ON table_phones.phone_type_id = table_phone_types.id;

SELECT * FROM view_phones;