class FriendshipsController < ApplicationController

  def new
  end

  def index
    # unless params[:search].empty?
    #   @search_result = User.where("email LIKE ?", "%#{params[:search]}%").first
    # end
  end

  def create
    friend = User.find_by(email: params[:email])
    if friend
      @friendship = current_user.friendships.build(friend_id: friend.id)
      if @friendship.save
        flash[:notice] = "Friend added."
        redirect_to root_url
      else
        flash[:error] = "Unable to add friend."
        redirect_to root_url
      end
    else
      flash[:notice] = "Friend not found."
      redirect_to root_url
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friend."
    redirect_to root_path
  end

  def payment

  end
end
