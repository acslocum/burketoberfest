class AddEverybodyWinsToGame < ActiveRecord::Migration
  def change
    add_column :games, :everybodyWins, :int
  end
end
