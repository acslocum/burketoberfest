class AddScoretypeToGame < ActiveRecord::Migration
  def change
    add_column :games, :scoreType, :int
  end
end
