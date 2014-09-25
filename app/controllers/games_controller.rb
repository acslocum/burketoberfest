class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
    #puts "game.new"
    #@game.attributes.keys.each { |x| puts x }
  end

  # GET /games/1/edit
  def edit
  end
  
  def new_win
    @person = Person.find_by(uid: cookies[:uid])
    @game = Game.find(params[:game_id])
    @rank = 1
    @events = Event.find_all_by_next_event
    @eventDescription = @events[0].description
  end
  
  def new_loss
    @person = Person.find_by(uid:cookies[:uid])
    @game = Game.find(params[:game_id])
    @rank = 2
    @events = Event.find_all_by_next_event
    @eventDescription = @events[0].description
  end
  
  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    if @game.save
      redirect_to @game, notice: 'Game was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    if @game.update(game_params)
      redirect_to @game, notice: 'Game was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    redirect_to games_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
      @person = Person.find_by(uid: cookies[:uid])

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
        params.require(:game).permit(:name,:players,:duration, :scoreType, :fixedAmount, :scoreCap, :event, :everybodyWins)
    end
end
