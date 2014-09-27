class Person < ActiveRecord::Base
  has_many :scores
  
  ALL_GAMES_BONUS = 1000
  
  def total
    points=0
    #events = Event.all
    # adds the total points (win or lose) for each completed event
    #events.each{|event| points += event.votes[1][id]}
    scores.each{|score| points += score.points.abs unless score.points.nil?}
    
    # then add the bonus for number of games completed
    bonusEligibleGamesCount = Game.all_non_fixed_games.count
    
    bonusEligibleGamesCompletedCount = 0
    gamesCompletedCount = scores.select {|score| score.game.eligibleForTotalGameCount}.map(&:game).uniq.count

    points +=ALL_GAMES_BONUS if gamesCompletedCount ==bonusEligibleGamesCount
    
    # add a bonus for all of the unique games, regardless of whether they're included in the all games bonus
    # so, for example, "pour a beer" is going to have a fixed payout and thus not be eligigle for the all games bonus
    # but, you can add to your exponential overall scoring if you participate in everything...
    if (gamesCompletedCount > 1)
        points += (gamesCompletedCount^2*2).abs
    end
    
    return points
  end
  
  
  def addScore(event: event, rank: rank, game: game, points:points)
      score = Score.create({event:event, rank: rank, person: self, game:game, points:points})
      #score.points = points
      return score
  end
  
end
