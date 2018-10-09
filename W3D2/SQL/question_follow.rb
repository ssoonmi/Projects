require_relative 'questions_db'
require_relative 'question'
require_relative 'user'
require_relative 'question_like'
require_relative 'reply'
require_relative 'model_base'


class QuestionFollow < ModelBase
  attr_accessor :question_id, :follower_id
  attr_reader :id

  # def self.all
  #   follows = QuestionsDatabase.instance.execute(<<-SQL)
  #     SELECT
  #       *
  #     FROM
  #       question_follows
  #   SQL
  #   follows.map { |datum| QuestionFollow.new(datum) }
  # end


  # def self.find_by_id(id)
  #   follow = QuestionsDatabase.instance.execute(<<-SQL, id)
  #     SELECT
  #       *
  #     FROM
  #       question_follows
  #     WHERE
  #       id = ?
  #   SQL
  #   QuestionFollow.new(follow.first)
  # end

  def self.followers_for_question_id(question_id)
    users = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        users
      JOIN question_follows
        ON question_follows.follower_id = users.id
      WHERE
        question_id = ?
    SQL
    users.map { |datum| User.new(datum) }
  end

  def self.followed_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        questions
      JOIN question_follows
        ON question_follows.question_id = questions.id
      WHERE
        follower_id = ?
    SQL
    questions.map{ |datum| Question.new(datum) }
  end

  def self.most_followed_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
    SELECT
      questions.*
    FROM
      questions
    JOIN
      question_follows
      ON question_follows.question_id = questions.id
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
    @follower_id = options['follower_id']
  end
end
