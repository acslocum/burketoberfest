class Event < ActiveRecord::Base
    has_many :scores
  
  def votes
     points = 0
     scores.each do |score|
         puts "score"
         puts score.points
         points += score.points
     end

    return points
    #points
  end
  
  def self.next_event_hour
    Time.now.hour
  end
  
  def self.find_all_by_next_event
    #hour = (next_event_hour + 12) % 24
    #events = Event.find(:all, :conditions => ["time > ?", hour], :order => "time ASC")
    #next_time = events.first.time
    #events.select{ |event| event.time == next_time}
    Event.all
  end
end
