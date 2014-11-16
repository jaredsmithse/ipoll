class CreatePollsForReal < ActiveRecord::Migration
  def change
      add_column :polls, :question_id, :integer
      add_column :polls, :user_id, :integer
      add_column :polls, :answer_id, :integer
  end
end
