class ScoresController < ApplicationController
  before_action :set_score, only: [:show, :edit, :destroy]
  before_action :set_game, only: [:new, :index, :show, :edit, :destroy]
  
  def index
    @scores = Score.all
  end

  def show
  end
  
  def new
    #@score = @game.scores.create
  end
  
  
  def create
      @game = Game.find(params[:game_id])
      event = params[:score][:event]
      rank = params[:score][:rank]
      @score = @game.scores.create({:event => event, :rank => rank})
      if @score.save
        redirect_to @game, notice: "Winners don't use drugs!"
      else
        render action: 'new'
      end
  end

  def destroy
    @score.destroy
    redirect_to game_url @game
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:game_id])
    end
    
    def set_score
      @score = Score.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def score_params
      params.require(:score).permit(:event)
    end
  
end
