class Person < ActiveRecord::Base
  has_many :scores
  
  def total
    points=0
    events = Event.all
    events.each{|event| points += event.votes[1][id]}
    points
  end
  
end
