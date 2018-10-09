require_relative 'questions_db'
require_relative 'user'
require_relative 'reply'
require_relative 'question_follow'
require_relative 'question_like'

class Question
  attr_accessor :title, :body, :author_id
  attr_reader :id

  def self.all
    questions = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        questions
    SQL
    questions.map { |datum| Question.new(datum) }
  end

  def self.find_by_id(id)
    question = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL
    Question.new(question.first)
  end

  def self.find_by_author_id(author_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?
    SQL
    questions.map { |datum| Question.new(datum) }
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def author
    User.find_by_id(self.author_id)
  end

  def replies
    Reply.find_by_question_id(self.id)
  end

  def followers
    QuestionFollow.followers_for_question_id(self.id)
  end

  def likers
    QuestionLike.likers_for_question_id(self.id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(self.id)
  end

  def save
    if self.id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, self.title, self.body, self.author_id)
        INSERT INTO
          questions
        VALUES
          (?, ?, ?)
      SQL
      @id = SQLite3.Database.last_insert_row_id
    else
      QuestionsDatabase.instance.execute(<<-SQL, self.title, self.body, self.author_id, self.id)
        UPDATE
          questions( title, body, author_id)
        SET
          title = ?,
          body = ?,
          author_id = ?
        WHERE
          id = ?
      SQL
    end
  end

end
