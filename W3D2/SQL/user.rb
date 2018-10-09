require_relative 'questions_db'
require_relative 'question'
require_relative 'reply'
require_relative 'question_follow'
require_relative 'question_like'


class User
  attr_accessor :fname, :lname
  attr_reader :id

  def self.all
    users = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        users
    SQL
    users.map { |datum| User.new(datum) }
  end


  def self.find_by_id(id)
    user = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL
    User.new(user.first)
  end

  def self.find_by_name(fname, lname)
    user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname LIKE ? AND lname LIKE ?
    SQL
    User.new(user.first)
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    Question.find_by_author_id( self.id )
  end

  def authored_replies
    Reply.find_by_replier_id( self.id )
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id( self.id )
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id( self.id )
  end

  def average_karma
    avg_likes = QuestionsDatabase.instance.execute(<<-SQL, self.id)
    SELECT
      CAST (COUNT(question_likes.id) AS FLOAT) / COUNT( DISTINCT questions.id) AS avg_likes
    FROM
      users
    JOIN questions
      ON users.id = questions.author_id
    LEFT OUTER JOIN question_likes
      ON question_likes.question_id = questions.id
    GROUP BY
      users.id
    HAVING
      users.id = ?
    SQL
    avg_likes.first['avg_likes']
  end

  def save
    if self.id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, self.fname, self.lname)
        INSERT INTO
          users
        VALUES
          (?, ?)
      SQL
      @id = SQLite3.Database.last_insert_row_id
    else
      QuestionsDatabase.instance.execute(<<-SQL, self.fname, self.lname, self.id)
        UPDATE
          users( fname, lname)
        SET
          fname = ?,
          lname = ?
        WHERE
          id = ?
      SQL
    end
  end

end
