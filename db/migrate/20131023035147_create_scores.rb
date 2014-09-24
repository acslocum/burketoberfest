class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :rank
      t.integer :points
      t.references :game, index: true
      t.references :person

      t.timestamps
    end
  end
end
