class RemoveScoreCapFromScores < ActiveRecord::Migration
  def change
      remove_column :scores, :scoreCap
      add_column :games, :scoreCap, :int
  end
end
