# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all.page(params[:page]).per(15).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end

  def favorite_user_index
    @post = Post.find_by(params[:id])
    #一旦リファクタしたけどなんかバグってそう
    likes = @post.favorites.pluck(:user_id)
    @users = User.find(likes)
  end
end
