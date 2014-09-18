class LikesController < ApplicationController
before_action :find_micropost
respond_to :html, :js
  def create
    @micropost.like(current_user.id)
    respond_with user_path(id: current_user.id)
  end

  def destroy
    @micropost.unlike(current_user.id)
    respond_with user_path(id: current_user.id)
  end

  private

  def find_micropost
  @micropost = Micropost.find(params[:like][:micropost_id])
  end

end