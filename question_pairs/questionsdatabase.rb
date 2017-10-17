require 'sqlite3'
require 'singleton'
class QuestionsDatabaseConnection
  include Singleton
  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end
