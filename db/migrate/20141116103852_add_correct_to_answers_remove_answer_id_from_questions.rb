class AddCorrectToAnswersRemoveAnswerIdFromQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :answer_id
    add_column :answers, :correct, :boolean, default: false
  end
end
