class UserGame
	include Mongoid::Document
	include Mongoid::Timestamps

	field :starter_matrix,    type: Array
    field :opponent_matrix,   type: Array
    field :level,             type: Integer, default: 5
    field :opponent_id,       type: String

    belongs_to :ip

    def intialization(ip,opponent_ip,level = 5)
      game = UserGame.new
  	  game.starter_matrix = Game.new.random_matrix(level)
  	  game.opponent_matrix = Game.new.random_matrix(level)
      game.level = level
  	  game.ip = ip
  	  game.opponent_id = opponent_ip.id
  	  game.save
    end


end