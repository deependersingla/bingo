class Ip
  include Mongoid::Document
  field :ip,   :type => String
  
  # Number of wins
  field :human_win,         type: Integer, default: 0
  field :computer_win,      type: Integer, default: 0
  field :tie,               type: Integer, default: 0

  has_many :game
end
