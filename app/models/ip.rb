class Ip
  include Mongoid::Document
  field :ip,   :type => String
  
  # Number of wins
  field :human_win,         type: Integer, default: 0
  field :computer_win,      type: Integer, default: 0
  field :tie,               type: Integer, default: 0

  has_many :game

  def global_stat
    human_win = 0
    comp_win = 0
    tie = 0
    Ip.all.each do |ip|
      human_win += ip.human_win
      comp_win += ip.computer_win
      tie += ip.tie
    end
    global_stat = {:human_win => human_win, :comp_win => comp_win, :tie => tie}
  end
end
