
class QuestionLike

  def self.likers_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      users.id, users.fname, users.lname
    FROM
      users
    JOIN
      question_likes ON users.id = question_likes.user_id
    WHERE
      question_likes.question_id = ?

    SQL

    data.map do |liker|
      User.new(liker)
    end

  end

  def self.num_likes_for_question(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      COUNT(*)
    FROM
      users
    JOIN
      question_likes ON users.id = question_likes.user_id
    WHERE
      question_likes.question_id = ?
    GROUP BY
      question_id
    SQL
  end

  def self.liked_questions_for_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      title, body, author_id
    FROM
      questions
    JOIN
      question_likes ON questions.id = question_likes.question_id
    WHERE
      question_likes.user_id = ?
    GROUP BY
      questions.title

    SQL

    data.map do |liker|
      Question.new(liker)
    end
  end

  def self.most_liked_questions(n)
    data = QuestionsDatabase.instance.execute(<<-SQL, n)
    SELECT
      questions.title, questions.body, questions.author_id
    FROM
      questions
    JOIN
      question_likes ON questions.id = question_likes.question_id
    GROUP BY
      questions.id
    ORDER BY
      COUNT(*) DESC
    LIMIT
      ?
    SQL

    data.map do |liker|
      Question.new(liker)
    end
  end
end
