# require_relative 'questiondatabase'
# require_relative 'user'
# require_relative 'reply'
require_relative 'model_base'

class Question < ModelBase
  attr_accessor :id, :title, :body, :author_id

  #why is this on the Question class?
  def self.most_liked(n)
    QuestionLiked.most_liked_questions(n)
  end

  def self.find_by_author_id(author_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?
    SQL

    data.map do |question|
      Question.new(question)
    end

  end

  def self.table
    "questions"
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def author
    User.find_by_id(@author_id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

end
