class ModelBase
  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{self.table}
      WHERE
        id = ?
    SQL
    self.new(data.first)
  end



  def save
    raise "User already exists." if @id

    QuestionsDatabase.instance.execute(<<-SQL)
      INSERT INTO
        #{param_names}
      VALUES
        #{param_values}
    SQL
    @id = QuestionsDatabase.instance.last_insert_row_id
  end


end

# class User < ModelBase
#   def self.table
#     'users'
#   end
# end
#
# User.find_by_id(1)
