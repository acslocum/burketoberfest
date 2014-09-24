class Score < ActiveRecord::Base
  belongs_to :game
  belongs_to :person
  
  WIN_FACTOR=5
  LOSE_FACTOR=1
  
  def time
    created_at.getlocal.strftime("%l:%M %P")
  end
  
  def minutes_since(last_time)
    (created_at.getlocal-last_time).to_i/60
  end
  
  def points_since(last_time)
    return minutes_since(last_time)*WIN_FACTOR if winner?
    minutes_since(last_time)*LOSE_FACTOR
  end
  
  def event_name
    Event.find(event).name
  end
  
  def result
    return "Won" if winner?
    "Lost"
  end
  
  def winner?
    rank==1
  end
end
