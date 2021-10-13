class UnlikesController < ApplicationController

  def create
    @unlike = current_user.unlikes.create(post_id: params[:post_id])
    redirect_back(fallback_location: @unlike)
  end

  def destroy
    @unlike = Unlike.find_by(post_id: params[:post_id], user_id: current_user.id)
    @unlike.destroy
    redirect_back(fallback_location: root_path)
  end
end
