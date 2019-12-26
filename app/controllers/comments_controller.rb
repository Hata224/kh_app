# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :validate_user, only: %i[create destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to post_path(@post), notice: '提案しました'
    elsif @comment.content.empty?
      redirect_to post_path(@post), alert: 'メッセージを入力してください'
    else
      redirect_to post_path(@post), alert: '500文字以内で入力してください'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find_by(post_id: params[:post_id])
    @comment.destroy
    if @comment.destroy
      redirect_to post_path(@post), notice: '投稿を削除しました'
    else
      redirect_to post_path(@post), alerts: '投稿を削除できませんでした'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def validate_user
    @post = Post.find(params[:post_id])
    @comment = Comment.find_by(post_id: params[:post_id])
    redirect_to post_path(@post), alert: '投稿者はこの操作はできません' if @post.user_id == current_user.id
  end
end
