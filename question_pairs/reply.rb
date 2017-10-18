# require_relative 'questiondatabase'
# require_relative 'user'
# require_relative 'question'

class Reply
  attr_accessor :id, :question_id, :parent_id, :user_id, :body

  def self.find_by_id(id)
    # debugger
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL
    # debugger
    Reply.new(data.first)
  end
  def self.find_by_user_id(user_id)
    # debugger
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL
    # debugger
    Reply.new(data.first)
  end
  def self.find_by_parent_id(parent_id)
    # debugger
    data = QuestionsDatabase.instance.execute(<<-SQL, parent_id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL
    # debugger
    Reply.new(data.first)
  end
  def self.find_by_question_id(question_id)
    # debugger
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL
    # debugger
    Reply.new(data.first)
  end
  def self.find_child_by_parent_id(parent_id)
    # debugger
    data = QuestionsDatabase.instance.execute(<<-SQL, parent_id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?
    SQL
    # debugger
    Reply.new(data.first)
  end


  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
    @user_id = options['user_id']
    @body = options['body']
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_id)
  end

  def child_reply
    Reply.find_child_by_parent_id(@id)
  end
end
