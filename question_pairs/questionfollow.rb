require 'byebug'
class QuestionFollow

  def self.followers_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.id, users.fname, users.lname
      FROM
        question_follows
      JOIN
        users ON question_follows.author_id = users.id
      WHERE
        question_id = ?
    SQL

    data.map do |user|
      User.new(user)
    end
  end
  def self.followed_questions_for_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.id, questions.title, questions.body, questions.author_id
      FROM
        question_follows
      JOIN
        questions ON question_follows.question_id = questions.id
      WHERE
        question_follows.author_id = ?
    SQL

    data.map do |question|
      Question.new(question)
    end
  end

  def self.most_followed_questions(n)
    data = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        -- questions.title, questions.body, COUNT(*) AS Number_of_Followers
        questions.id, questions.title, questions.body, questions.author_id
      FROM
        questions
      LEFT OUTER JOIN
        question_follows ON question_follows.question_id = questions.id
      GROUP BY
        question_follows.question_id
      ORDER BY
        COUNT(*) DESC
      LIMIT
        ?;

    SQL
    data.map do |question|
      Question.new(question)
    end
  end
  def self.most_followed
    QuestionFollow.most_followed_questions(1)
  end
end
