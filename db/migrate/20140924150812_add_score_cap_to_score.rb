class AddScoreCapToScore < ActiveRecord::Migration
  def change
    add_column :scores, :scoreCap, :int
  end
end
