PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;




CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER,
  follower_id INTEGER,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (follower_id) REFERENCES users(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body TEXT NOT NULL,
  parent_reply_id INTEGER,
  replier_id INTEGER,
  question_id INTEGER,

  FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
  FOREIGN KEY (replier_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  like_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (like_id) REFERENCES users(id)
);

INSERT INTO
  users(fname, lname)
VALUES
  ('Oliver', 'Ball'),
  ('Mashu', 'Duek'),
  ('Simcha', 'Cohen'),
  ('Sallem', 'Ahmed'),
  ('Soon-Mi', 'Sugihara');

INSERT INTO
  questions(title,body,author_id)
VALUES
  ('Life','What is the meaning of life?',4),
  ('Nationality', 'What is your nationality?',5),
  ('purpose','why are we here', 4);

INSERT INTO
  question_follows(question_id,follower_id)
VALUES
  (1, 2),
  (2, 3),
  (1, 4),
  (2, 5),
  (2, 1);

INSERT INTO
  replies(body, parent_reply_id, replier_id, question_id)
VALUES
  ('App Academy', NULL, 2, 1),
  ('Argentina', NULL, 2, 2),
  ('Getting a job from App Academy', 1, 1, 1),
  ('Morocco', NULL, 3, 2),
  ('France', 4, 3, 2),
  ('Egypt', NULL, 4, 2),
  ('I did not visit France yet!', 5, 5, 2);

INSERT INTO
  question_likes(question_id, like_id)
VALUES
  (1, 5),
  (2, 4),
  (1, 1),
  (1, 3),
  (2, 2);
