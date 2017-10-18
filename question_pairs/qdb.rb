require 'sqlite3'
require 'singleton'
require 'byebug'
#distribute to other files - spead the wealth
require_relative 'question'
require_relative 'user'
require_relative 'reply'
require_relative 'questionfollow'
require_relative 'question_like'
require_relative 'model_base'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end

end

# if $PROGRAM_NAME == __FILE__
  # x = User.find_by_id(1)
  # debugger
# end
