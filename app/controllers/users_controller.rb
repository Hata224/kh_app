# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @user = User.find_by(id: @post.user_id)
  end
end
