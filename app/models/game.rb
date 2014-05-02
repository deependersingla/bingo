class Game
	include Mongoid::Document
	include Mongoid::Timestamps

  field :starter_matrix,    type: Array
  field :opponent_matrix,   type: Array
  field :oponent_id,        type: String
  belongs_to :user

  def game_initialization(user,opponent)
  	game = Game.new
  	game.starter_matrix = random_matrix
  	game.opponent_matrix = random_matrix
  	game.user = user
  	game.save
  end

  def random_matrix
    d = (1..25).to_a.shuffle
    g =[]
    (1..5).each do |x|
      z = x-1
      g.push(d[5*z..5*x-1])
    end
    g
  end

  def update_matrix(number, user)
    game = Game.where(user_id: user.id).last
    game_hash = {}
    game_hash[:user_matrix] = game.starter_matrix
    game_hash[:computer_matrix] = game.opponent_matrix
    game_hash[:number] = number
    user_matrix, computer_matrix = UpdateMatrix.update(game_hash)
    game.starter_matrix = user_matrix
    game.opponent_matrix = computer_matrix
    game.save
  end
end