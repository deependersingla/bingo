class GameController < ApplicationController
  #require 'actionpack/action_caching'
   #caches_action :play
  def start_game
    if !Ip.where(ip: request.remote_ip).exists? 
      Ip.create(ip: request.remote_ip)
    end

    Game.new.game_initialization(Ip.where(ip: request.remote_ip).last, 5)
    redirect_to :action => :play
  end



  def computer_win
    game = Game.where(user_id: current_user.id).last
    @matrix = game.opponent_matrix
  end

  def global_stats
    @global_stat = Ip.new.global_stat
    @level_winner = Game.new.level_winner_info
    @level
  end

  def play
    if Ip.where(ip: request.remote_ip).exists? 
      game = Game.where(ip_id: Ip.where(ip: request.remote_ip).last.id).last
      # computer
      comp = ComputerPlay.new(game.opponent_matrix)
      @comp_cut_lines = comp.total_cut_lines
      if @comp_cut_lines <= game.level + 5
        @matrix = game.starter_matrix
        @comp_matrix = game.opponent_matrix
        hum = ComputerPlay.new(@matrix)
        @human_cut_lines = hum.total_cut_lines
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
    ip.tie += 1
    ip.save
    last_level = ip.game.last.level
    Game.new.game_initialization(ip, last_level)
    redirect_to :action => :play
  end

  def next_level
    ip = Ip.where(ip: request.remote_ip).last
    ip.human_win += 1
    ip.save
    last_level = ip.game.last.level
    Game.new.game_initialization(ip, last_level+2)
    redirect_to :action => :play
  end

  def start_level_again
    ip = Ip.where(ip: request.remote_ip).last
    last_level = ip.game.last.level
    Game.new.game_initialization(ip, last_level)
    redirect_to :action => :play
  end

  def comp_win
    ip = Ip.where(ip: request.remote_ip).last
    ip.computer_win += 1
    ip.save
    last_level = ip.game.last.level
    Game.new.game_initialization(ip, last_level)
    redirect_to :action => :play
  end
end
