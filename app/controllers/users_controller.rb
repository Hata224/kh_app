# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    # @post = Post.find(params[:id])
    @user = User.find(params[:id])
  end
end
