class AddCurrentAndAcceptingToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :current, :boolean, default: false
    add_column :questions, :accepting, :boolean, default: false
  end
end
