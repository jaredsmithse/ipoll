class AddPresentingToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :presenting, :boolean, default:false
  end
end
