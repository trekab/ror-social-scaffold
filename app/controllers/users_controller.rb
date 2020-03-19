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
    @friend = Friend.find_by(user_id: params[:id], pal_id: current_user.id)
    @friend_inverse = Friend.find_by(user_id: current_user.id, pal_id: params[:id])

    if !@friend
      @friend = Friend.new(user_id: params[:id], pal_id: current_user.id)
      @friend.save
    elsif !@friend_inverse
      @friend = Friend.new(user_id: current_user.id, pal_id: params[:id])
      @friend.save
    end

    redirect_to root_path
  end

  def accept_friendship
    @friend = Friend.find_by(user_id: current_user.id, pal_id: params[:id])
    @friend.accepted!

    redirect_to root_path
  end
end
