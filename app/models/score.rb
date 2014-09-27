class Score < ActiveRecord::Base
  belongs_to :game
  belongs_to :person
  belongs_to :event

WIN_FACTOR=2
LOSE_FACTOR=1

  
  def time
    return created_at.getlocal.strftime("%l:%M %P")
  end
  
  def createdTime
      return time1 = Time.new.getlocal if created_at == nil
      created_at.getlocal
  end

    def minutes_since(last_time)
        (createdTime-last_time).to_i/60
    end

    def pointsForTime(last_time)
        return minutes_since(last_time).abs*WIN_FACTOR if winner?
        minutes_since(last_time).abs*LOSE_FACTOR
    end


  def event_name
    if (event == nil)
        return ""
    else
        return Event.find(event).name
    end
  end
 
  def result
    return "Won" if winner?
    "Lost"
  end
  
  def winner?
    rank==1
  end
end
