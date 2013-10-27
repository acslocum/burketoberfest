class RemoveArmWrestling < ActiveRecord::Migration
  def change
    Event.delete(7)
    Event.delete(6)
    Event.delete(5)
  end
end
