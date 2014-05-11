class GameController < ApplicationController
  

  def start_game
    if !Ip.where(ip: request.remote_ip).exists? 
      Ip.create(ip: request.remote_ip)
    end

    Game.new.game_initialization(Ip.where(ip: request.remote_ip).last)
    redirect_to :action => :play
  end



  def computer_win
    game = Game.where(user_id: current_user.id).last
    @matrix = game.opponent_matrix
  end

  def global_stats
    @global_stat = Ip.new.global_stat
    @level_winner = Game.new.level_winner_info
  end

  def play
    if Ip.where(ip: request.remote_ip).exists? 
      game = Game.where(ip_id: Ip.where(ip: request.remote_ip).last.id).last
      # computer
      comp = ComputerPlay.new(game.opponent_matrix)
      cut_lines = comp.total_cut_lines
      if cut_lines <= game.level + 5
        @matrix = game.starter_matrix
      end
    else 
     redirect_to :action => :start_game
    end
  end

  skip_before_action :verify_authenticity_token


  def search
    Game.new.update_matrix(params[:q], Ip.where(ip: request.remote_ip).last)
    redirect_to :action => :play
  end

  def comp_matrix
    @matrix = Game.last.opponent_matrix
  end

  def restart_level
    ip = Ip.where(ip: request.remote_ip).last
    last_level = ip.game.last.level
    Game.new.game_initialization(ip, last_level)
    redirect_to :action => :play
  end
end
