# require_relative 'questiondatabase'
# require_relative 'question'
# require_relative 'reply'
require_relative 'model_base'
require 'byebug'
class User < ModelBase
  attr_accessor :id, :fname, :lname

  def self.table
    'users'
  end


  def self.average_karma(id)
    # debugger
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL
    # debugger
    User.new(data.first)
  end


  def self.find_by_name(lname)
    # debugger
    data = QuestionsDatabase.instance.execute(<<-SQL, lname)
      SELECT
        *
      FROM
        users
      WHERE
        lname = ?
    SQL
    # debugger
    User.new(data.first)
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end


  #TODO copy/paste into Question and Reply
  # def save
  #   raise "Users already exists." if @id
  #   QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
  #     INSERT INTO
  #       users(fname, lname)
  #     VALUES
  #       (?, ?)
  #   SQL
  #   @id = QuestionsDatabase.instance.last_insert_row_id
  # end
  #TO DO: Put into question and reply classes
  def update
    raise "User does not exist" unless @id
    QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname, @id)
      UPDATE
        users
      SET
        fname = ?, lname = ?
      WHERE
        id = ?
    SQL
    User.find_by_id(@id)
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end


    def param_names
      # debugger
      'users(fname, lname)'
    end

  def param_values
    "(\'#{@fname}\', \'#{@lname}\')"
  end

 #incomplete:
  def average_karma
    numquestions = authored_questions.length
    numlikes = QuestionLike.liked_questions_for_user_id(@id)

    if numquestions == 0
      return 0
    end

    numlikes/numquestions

  end
end
