class GameController < ApplicationController
  before_filter :authenticate_user!

  def start_game
    Game.new.game_initialization(current_user,"enter oponent in future")
    redirect_to :action => :play
  end

  def computer_win
    game = Game.where(user_id: current_user.id).last
    @matrix = game.opponent_matrix
  end

  def computer_win
    game = Game.where(user_id: current_user.id).last
    @matrix = game.opponent_matrix
  end

  def play
    game = Game.where(user_id: current_user.id).last
    # computer
    comp = ComputerPlay.new(game.opponent_matrix)
    cut_lines = comp.total_cut_lines
    if cut_lines <= 7
    @matrix = game.starter_matrix
    
    #else 
    #  redirect_to :action => :computer_win
    # add a partial here so that ajax can be used
  end
end
   skip_before_action :verify_authenticity_token


  def search
    Game.new.update_matrix(params[:q],current_user)
    redirect_to :action => :play
  end

  
end
