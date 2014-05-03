class UpdateMatrix
  def self.update(game_hash)
    user_matrix = find_element(game_hash[:user_matrix], game_hash[:number])
    computer_matrix = find_element(game_hash[:computer_matrix], game_hash[:number])
    user_comp = ComputerPlay.new(user_matrix)
    user_lines_cut = user_comp.total_cut_lines
    if user_lines_cut < game_hash[:level]
      comp = ComputerPlay.new(computer_matrix)
      element = comp.find_best_element
      user_matrix = find_element(game_hash[:user_matrix], element)
      computer_matrix = find_element(game_hash[:computer_matrix], element)
    end
    return user_matrix, computer_matrix
  end

  def self.find_element(matrix,number)
  	matrix.map! {|line| line.map! {|x| x == (number.to_i)? 0:x}}
  end
end