class FriendshipsController < ApplicationController
    def create
        @friend_requests = Friendship.new(friend_id:params[:user], user:current_user)

        if @friend_requests.save
            flash[:notice] = 'Request sent'
            redirect_to users_path
            
        else
            flash[:alert] = 'Error while sending request' 
        end 
    end

    def index
        @pending_requests = current_user.pending_friends
    end


  end
  