# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[show create]
  before_action :find_post, only: %i[show edit update destroy]
  before_action :set_favorite, only: %i[index show]
  before_action :validate_user, only: %i[edit update destroy]

  PER = 10

  def index
    @all_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(1000).pluck(:post_id))
    @posts = Post.page(params[:page]).per(PER).order(created_at: :desc)
  end

  def show
    @unlike = Unlike.new
    # 未実装のため一旦コメントアウト
    # @bookmark = Bookmark.new
    @user = User.find_by(id: @post.user_id)
    @comments = @post.comments.all
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
    elsif @post.title.empty?
      redirect_to new_post_path, alert: 'タイトルを入力してください'
    else
      flash[:alert] = 'タイトルは50字以内、詳細は1000字以内で入力してください'
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: '投稿内容を変更しました'
    elsif @post.title.empty?
      redirect_to edit_post_path, alert: 'タイトルを入力してください'
    else
      render :edit, alert: '投稿内容を変更できませんでした'
    end
  end

  def destroy
    @post.destroy ? flash[:notice] = '投稿を削除しました' : flash[:alerts] = '投稿を削除できませんでした'
    redirect_to posts_path
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def set_favorite
    @favorite = Favorite.new
  end

  def post_params
    params.require(:post).permit(:title, :body, :image, :content, :tag_list)
  end

  def validate_user
    redirect_to posts_path, alert: '投稿者以外はこの操作はできません' if @post.user != current_user
  end
end
