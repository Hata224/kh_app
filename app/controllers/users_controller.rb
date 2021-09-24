# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all.page(params[:page]).per(15).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end

  def following
    @user = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  def favorite_user_index
    @post = Post.find_by(params[:id])
    likes = @post.favorites.includes(:user).all.pluck(:user_id)
    @users = User.find(likes)
  end
end
