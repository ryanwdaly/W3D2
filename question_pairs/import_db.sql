-- DROP TABLE users;
DROP TABLE IF EXISTS users;
CREATE TABLE  users (
    id INTEGER PRIMARY KEY,
    fname VARCHAR(100),
    lname VARCHAR(100)
);

DROP TABLE IF EXISTS questions;
CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title VARCHAR(100),
    body TEXT,
    author_id INTEGER NOT NULL,
    FOREIGN KEY (author_id) REFERENCES users(id)
);
DROP TABLE IF EXISTS question_follows;
CREATE TABLE question_follows(
  author_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (author_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS replies;
CREATE TABLE replies(
  id INTEGER PRIMARY KEY,
  body TEXT,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);
--
DROP TABLE IF EXISTS question_likes;
CREATE TABLE question_likes(
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users(fname, lname)
VALUES
  ('John', 'Doe');

  INSERT INTO
    users(fname, lname)
  VALUES
    ('Jane', 'Daw');

INSERT INTO
  questions(title, body, author_id)
VALUES
  ('why?', 'hello', '1');

INSERT INTO
  replies(body, question_id, parent_id, user_id)
VALUES
  ('this is a parent reply!', '1', NULL, '1');

INSERT INTO
  replies(body, question_id, parent_id, user_id)
VALUES
  ('this is a reply a reply!', '1', '1', 1);

  INSERT INTO question_follows(author_id, question_id) VALUES (1, 1);
