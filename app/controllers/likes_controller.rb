#WTF, #omg #damnitrubymine

class LikesController < ApplicationController

  def create
    @micropost = Micropost.find(params[:like][:micropost_id])
    @micropost.like(@micropost,User.find(params[:like][:liker_id]))
    respond_to do |format|
      format.html { redirect_to @micropost }
      format.js {}
    end
  end

  def destroy
    @micropost = Micropost.find(params[:like][:micropost_id])
    @micropost.unlike(@micropost,User.find(params[:like][:liker_id]))
    respond_to do |format|
      format.html { redirect_to @micropost }
      format.js {}
    end
  end
end