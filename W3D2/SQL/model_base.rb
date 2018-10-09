require 'byebug'
require 'active_support/inflector'
require_relative 'questions_db'

class ModelBase

  def self.find_by_id(id)
    database = self.to_s.tableize
    models = QuestionsDatabase.instance.execute(<<-SQL, id: self.id)
      SELECT
        *
      FROM
        #{database}
      WHERE
        id = :id
    SQL
    models.map { |datum| self.new(datum) }.first
  end

  def self.all
    database = self.to_s.tableize
    models = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        #{database}
    SQL
    models.map { |datum| self.new(datum) }
  end

  def save
    database = self.class.to_s.tableize
    # str1 = "("
    # self.instance_variables.each_with_index do |a, idx|
    #   str1 += "?, " unless idx >= self.instance_variables.length - 2
    # end
    # str1 += "?)"
    # puts str1
    #
    # str2 = ""
    # vars = []
    # self.instance_variables.each_with_index do |variable, idx|
    #   var = send(variable.to_s[1..-1].to_sym)
    #   vars << var
    #   str2 += variable.to_s[1..-1] + " = #{var}"
    #   str2 += "," unless idx >= self.instance_variables.length - 1
    # end
    # puts vars
    # puts str2

    hash_var = Hash.new

    if self.id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, hash_var)
        INSERT INTO
          #{database}
        VALUES
          #{str1}
      SQL
      @id = SQLite3.Database.last_insert_row_id
    else
      QuestionsDatabase.instance.execute(<<-SQL, vars[0])
        UPDATE
          #{database}( fname, lname)
        SET
          #{str2}
        WHERE
          id = ?
      SQL
    end
  end

end
