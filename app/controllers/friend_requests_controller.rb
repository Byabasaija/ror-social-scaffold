class FriendRequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    request = current_user.friend_requests_as_sender.build(receiver_id: params[:user])
    if request.save
      flash[:notice] = 'Request sent'
    else
      flash[:alert] = 'There was an error while sending request'
    end
    redirect_to users_path
  end

  def accept
    user = User.find(params[:id])
    current_user.confirm_friend(user)
    flash[:notice] = "You have accepted the friendship request with #{user.name}"
    current_user.friend_requests_as_receiver.find_by(sender: user).destroy
    redirect_to users_path
  end

  def reject
    user = User.find(params[:id])
    flash[:notice] = "You have rejected the friendship request with #{user.name}"
    current_user.friend_requests_as_receiver.find_by(sender: user).destroy
    redirect_to users_path
  end
end
