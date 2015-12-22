class GameApiController < ApplicationController
  

  #todo trigger for game change and score
  def play_game
  	if Ip.where(ip: params[:user_id]).exists? 
      ip = Ip.where(ip: params[:user_id]).last
      game = ip.game[-1]
      game = Game.new.game_initialization(ip, 5) unless game
      comp = ComputerPlay.new(game.opponent_matrix)
      @comp_cut_lines = comp.total_cut_lines

      if @comp_cut_lines >= game.level 
        last_level = ip.game.last.level
        ip.computer_win += 1
        ip.save
        game = Game.new.game_initialization(ip, last_level)
        comp = ComputerPlay.new(game.opponent_matrix)
        params[:human_cut_lines] = 0
        @comp_cut_lines = comp.total_cut_lines
      end

      @matrix = game.starter_matrix
      @comp_matrix = game.opponent_matrix
      hum = ComputerPlay.new(@matrix)
      @human_cut_lines = hum.total_cut_lines
      unless params[:human_cut_lines]
        params[:human_cut_lines] = 0
      end
      if params[:wrong_number]
        reward = 0
      else
        if @human_cut_lines == 5
          ip.human_win += 1
          ip.save
          reward = 3
        elsif @human_cut_lines > params[:human_cut_lines].to_i
          reward = 1
        else
          reward = 0
        end 
      end

      render json: {
        matrix: @matrix,
        input_vector: mapping_of_number(@matrix),
        human_cut_lines: @human_cut_lines ,
        reward: reward,
        human_win: ip.human_win,
        computer_win: ip.computer_win,
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
    else
      params[:wrong_number] = true
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