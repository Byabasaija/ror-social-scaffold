class FriendshipsController < ApplicationController
  def create
    @friend_requests = current_user.inverse_friendships.build(user_id: params[:user])

    if @friend_requests.save
      flash[:notice] = 'Request sent'
    else
      flash[:alert] = 'Error while sending request'
    end
    redirect_to users_path
  end

  def accept
    user = User.find(params[:id])
    current_user.confirm_friend(user)
    flash[:notice] = "You have accepted the friendship request with #{user.name}"
    redirect_to friendships_path
  end

  def reject
    user = User.find(params[:id])
    current_user.reject_friend(user)
    flash[:notice] = "You have rejected the friendship request with #{user.name}"
    redirect_to friendships_path
  end

  def index
    @pending_requests = current_user.pending_friends
  end
end
