class GameApiController < ApplicationController
  

  #todo trigger for game change and score
  def play_game
  	if Ip.where(ip: params[:user_id]).exists? 
      game = Ip.where(ip: params[:user_id]).last.game[-1]
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
        reward = @human_cut_lines - @comp_cut_lines
        render json: {
          matrix: @matrix,
          input_vector: mapping_of_number(@matrix),
          lines_cut: @human_cut_lines ,
          reward: reward,
          comp_cut_lines: @comp_cut_lines
        }
    else 
      render json: {
      	text: "please give id"
      }
    end
  end

  def give_number
  	user = Ip.where(ip: params[:user_id]).last
  	game = user.game[-1]
  	number = reverse_mapping_to_number(game.starter_matrix, params[:q])
  	#todo 00 may be want to update reward
  	unless number == 0 || number == "Y"
  	  Game.new.update_matrix(number, user)
    end
    redirect_to :action => :play_game, params: params
  end

  protected
    def mapping_of_number(matrix)
      temp_array =[]
      matrix.each do |array|
       	array.each do |element|
       	  if element == "Y" || element == 0
       	    temp_array << 0
       	  else
            temp_array << 1 
       	   end
       	end
      end
      return temp_array
    end

    def reverse_mapping_to_number(matrix, number)
      return matrix.flatten[number.to_i - 1]
    end
end