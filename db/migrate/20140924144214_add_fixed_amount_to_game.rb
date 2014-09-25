class AddFixedAmountToGame < ActiveRecord::Migration
  def change
    add_column :games, :fixedAmount, :int
  end
end
