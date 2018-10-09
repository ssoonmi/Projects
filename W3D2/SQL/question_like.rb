require_relative 'questions_db'
require_relative 'question'
require_relative 'user'
require_relative 'question_follow'
require_relative 'reply'

class QuestionLike
  attr_accessor :question_id, :like_id
  attr_reader :id

  def self.all
    question_likes = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        question_likes
    SQL
    question_likes.map { |datum| QuestionLike.new(datum) }
  end


  def self.find_by_id(id)
    question_like = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = ?
    SQL
    QuestionLike.new(question_like.first)
  end

  def self.likers_for_question_id(question_id)
    users = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        users
      JOIN question_likes
        ON question_likes.like_id = users.id
      WHERE
        question_id = ?
    SQL
    users.map {|datum| User.new(datum)}
  end

  def self.num_likes_for_question_id(question_id)
    num_likes = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(question_id) AS num_likes
      FROM
        question_likes
      GROUP BY
        question_id
      HAVING
        question_id = ?
    SQL
    num_likes.first['num_likes']
  end

  def self.liked_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_likes
        ON questions.id = question_likes.question_id
      JOIN
        users
        ON users.id = question_likes.like_id
      WHERE
        users.id = ?
    SQL
    questions.map { |datum| Question.new(datum) }
  end

  def most_liked_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
    SELECT
      questions.*
    FROM
      questions
    JOIN
      question_likes
      ON question_likes.question_id = questions.id
    GROUP BY
      questions.id
    ORDER BY
      COUNT(questions.id) DESC
    LIMIT
      ?
    SQL
    questions.map {|datum| Question.new(datum)}
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @like_id = options['like_id']
  end
end
