require 'Set'

class Person < ActiveRecord::Base
  has_many :scores
  
  ALL_GAMES_BONUS = 1000
  
  def total
    points=0
    #events = Event.all
    # adds the total points (win or lose) for each completed event
    #events.each{|event| points += event.votes[1][id]}
    scores.each{|score| points += score.points}
    
    # then add the bonus for number of games completed
    bonusEligibleGamesCount = 0
    allGames = Game.all
    for index in 0 ... allGames.size
        if ( allGames[index].eligibleForTotalGameCount())
            bonusEligibleGamesCount += 1
        end
    end
    
    bonusEligibleGamesCompletedCount = 0
    gamesCompleted = Set.new
    for index in 0 ... scores.size
       if (scores[index].game.eligibleForTotalGameCount())
           gamesCompleted.add(scores[index].game)
       end
    end
    
    if (gamesCompleted.size ==bonusEligibleGamesCount)
        points +=ALL_GAMES_BONUS
    end
    
    # add a bonus for all of the unique games, regardless of whether they're included in the all games bonus
    # so, for example, "pour a beer" is going to have a fixed payout and thus not be eligigle for the all games bonus
    # but, you can add to your exponential overall scoring if you participate in everything...
    if (gamesCompleted.size > 1)
        points += gamesCompleted.size^2*2
    end
    
    return points
  end
  
  
  def addScore(event: event, rank: rank, game: game, points:points)
      score = Score.create({event:event, rank: rank, person: self, game:game, points:points})
      #score.points = points
      return score
  end
  
end
