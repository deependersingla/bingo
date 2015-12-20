class GameApiController < ApplicationController
  

  #todo trigger for game change and score
  def play_game
  	if Ip.where(ip: params[:user_id]).exists? 
      game = Game.where(ip_id: Ip.where(ip: params[:user_id]).last.id).last
      game = Game.new.game_initialization(Ip.where(ip: params[:user_id]).last, 5) unless game
      comp = ComputerPlay.new(game.opponent_matrix)
      @comp_cut_lines = comp.total_cut_lines
      if @comp_cut_lines >= game.level 
        ip = Ip.where(ip: params[:user_id]).last
        last_level = ip.game.last.level
        game = Game.new.game_initialization(ip, last_level)
        comp = ComputerPlay.new(game.opponent_matrix)
        @comp_cut_lines = comp.total_cut_lines
      end
        @matrix = game.starter_matrix
        @comp_matrix = game.opponent_matrix
        hum = ComputerPlay.new(@matrix)
        @human_cut_lines = hum.total_cut_lines
        render json: {
          matrix: @matrix,
          lines_cut: @human_cut_lines ,
          comp_cut_lines: @comp_cut_lines
        }
    else 
      render json: {
      	text: "please give id"
      }
    end
  end

  def give_number
  	Game.new.update_matrix(params[:q], Ip.where(ip: params[:user_id]).last)
    redirect_to :action => :play_game, params: params
  end
end