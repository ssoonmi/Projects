require_relative 'questions_db'
require_relative 'question'
require_relative 'user'
require_relative 'question_follow'
require_relative 'question_like'


class Reply
  attr_accessor :body, :parent_reply_id, :replier_id, :question_id
  attr_reader :id

  def self.all
    replies = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        replies
    SQL
    replies.map { |datum| Reply.new(datum) }
  end


  def self.find_by_id(id)
    reply = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL
    Reply.new(reply.first)
  end

  def self.find_by_replier_id(replier_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, replier_id)
      SELECT
        *
      FROM
        replies
      WHERE
        replier_id = ?
    SQL
    replies.map { |datum| Reply.new(datum) }

  end

  def self.find_by_question_id(question_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL
    replies.map { |datum| Reply.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @body = options['body']
    @parent_reply_id = options['parent_reply_id']
    @replier_id = options['replier_id']
    @question_id = options['question_id']
  end

  def author
    User.find_by_id(self.replier_id)
  end

  def question
    Question.find_by_id(self.question_id)
  end

  def parent_reply
    return false if self.parent_reply_id.nil?
    Reply.find_by_id(self.parent_reply_id)
  end

  def child_replies
    children = QuestionsDatabase.instance.execute(<<-SQL, self.id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_reply_id = ?
    SQL
    children.map { |datum| Reply.new(datum) }
  end

  def save
    if self.id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, self.body, self.parent_reply_id, self.replier_id, self.question_id)
        INSERT INTO
          replies
        VALUES
          (?, ?, ?, ?)
      SQL
      @id = SQLite3.Database.last_insert_row_id
    else
      QuestionsDatabase.instance.execute(<<-SQL, self.body, self.parent_reply_id, self.replier_id, self.question_id, self.id)
        UPDATE
          replies( body, parent_reply_id, replier_id, question_id)
        SET
          body = ?,
          parent_reply_id = ?,
          replier_id  = ?,
          question_id = ?
        WHERE
          id = ?
      SQL
    end
  end

end
