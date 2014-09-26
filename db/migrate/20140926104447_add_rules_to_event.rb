class AddRulesToEvent < ActiveRecord::Migration
  def change
    add_column :events, :rule1, :string
    add_column :events, :rule2, :string
    add_column :events, :rule3, :string
  end
end
