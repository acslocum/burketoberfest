class AddGameRefToScores < ActiveRecord::Migration
  def change
    add_column :scores, :game, :reference
  end
end
