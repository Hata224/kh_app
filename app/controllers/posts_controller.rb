# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: %i[show edit update destroy]
  before_action :validate_user, only: %i[edit update destroy]

  def index
    @posts = Post.order(created_at: :desc)
    @post = Post.find_by(params[:id])
    @user = User.find_by(id: @post.user_id)
  end

  def show
    @user = User.find_by(id: @post.user_id)
    @comments = @post.comments.includes(:user).all
    @comment = @post.comments.build(user_id: current_user.id) if current_user
  end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice: '投稿しました'
    elsif @post.errors.any?
      redirect_to new_post_path, alert: 'メッセージを入力してください'
    else
      render :new, alert: '投稿できませんでした'
    end
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: '投稿内容を変更しました'
    else
      render :edit, alert: '投稿内容を変更できませんでした'
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_path, notice: '投稿を削除しました'
    else
      redirect_to posts_path, alerts: '投稿を削除できませんでした'
    end
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :image, :content)
  end

  def validate_user
    if @post.user != current_user
      redirect_to posts_path, alert: '投稿者以外はこの操作はできません'
    end
  end
end
