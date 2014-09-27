class Game < ActiveRecord::Base
  has_many :scores
  
  PARTY_START_TIME=15
  SCAN_LATENCY_GAP = 2		# give everybody 2 minutes to scan all the results of a game


    def long_string
     "#{name}"
  end
  
  def addScore(event, rank, person)
	# get the prior scores for this game
	if (scores != nil)
	  scores.sort! { |a,b| a.created_at <=> b.created_at}
	end

	# if we already have too many priors, then don't build a new score
	points = 0

	# this is ugly, but given my shitty knowledge of ruby syntax this is how its going to roll for now.
	# for time-based games, figure out points based on what we did before...
	score = Score.new({event:event, rank: rank, person: person, game:self})
	if isTimeBased()
		lastGameTime = -1
		if (scores.size == 0)
			lastGameTime =    DateTime.new(2014,9,27,PARTY_START_TIME,0,0,"-4")
		else
			currentTime = Time.new
			lastGameTime = scores[-1].created_at
			countBack = -1

			while ((currentTime - lastGameTime) /60 < SCAN_LATENCY_GAP)

				countBack = countBack - 1
				lastGameTime = scores[countBack].created_at
			end
		end
	points = score.pointsForTime(lastGameTime)
	# for fixed games, the points are a set amount
	elsif isFixed()
		points = fixedAmount
	end

    # if we're over the score cap, no points for this one
    if ((scores.size >= scoreCap))
        points = 0
    end
    score.points = points
    
    # if it a game where one win means that everybody wins, find all people and give them a score. no event, voting, though
    if shouldEverybodyWin()
        people = Person.all
        people.each do |person|
            score =person.addScore(event:nil, rank:rank, game:self, points:@points)
        end
    end

    return score        # will call .save in teh controller
  end
  
  def eligibleForTotalGameCount
      !isFixed
  end
  
  def self.all_non_fixed_games
    where.not(scoretype: 2)
  end
  

  
private
    def isTimeBased
        scoreType==1
    end

    def isFixed
        scoreType==2
    end
    
    def shouldEverybodyWin
        everybodyWins==1
    end
        

end
