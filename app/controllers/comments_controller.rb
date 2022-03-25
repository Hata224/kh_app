# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_post, only: %i[create destroy validate_user]
  before_action :validate_user, only: %i[create destroy]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
       flash[:notice] = '提案しました'
    elsif @comment.content.empty?
       flash[:alert] = 'メッセージを入力してください'
    else
       flash[:alert] = '500文字以内で入力してください'
    end
    redirect_to post_path(@post)
  end

  def destroy
    @comment = Comment.find_by(id: params[:id], post_id: params[:post_id])
    @comment.destroy ? flash[:notice] = '投稿を削除しました' : flash[:alert] = '投稿を削除できませんでした'
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def validate_user
    @comment = Comment.find_by(post_id: params[:post_id])
    redirect_to post_path(@post), alert: '投稿者はこの操作はできません' if @post.user_id == current_user.id
  end
end
