class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def invite_to_friendship
    @friend = Friend.find_by(user_id: current_user.id, pal_id: params[:id])
    @inverse_friend = Friend.find_by(user_id: params[:id], pal_id: current_user.id)

    if !current_user.friends.include?(@friend) && !current_user.inverse_friends.include?(@inverse_friend)
      @friend = Friend.new(user_id: current_user.id, pal_id: params[:id])
      @friend.save
    end

    redirect_to users_path, notice: 'Friendship request sent!'
  end

  def accept_friendship
    @friend = Friend.find_by(user_id: params[:id], pal_id: current_user.id)
    @friend.accepted!

    redirect_to users_path, notice: 'Friendship request accepted!'
  end

  def reject_friendship
    @friend = Friend.find_by(user_id: params[:id], pal_id: current_user.id)
    @friend.destroy

    redirect_to users_path, notice: 'Friendship request rejected!'
  end
end
