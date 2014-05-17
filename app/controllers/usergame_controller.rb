class UsergameController < ApplicationController
	
	def start_game
      if !Ip.where(ip: request.remote_ip).exists? 
        Ip.create(ip: request.remote_ip)
      end

      # finding another ip and user
      UserGame.new.initialization(Ip.where(ip: request.remote_ip).last, )
      redirect_to :action => :play
    end

end