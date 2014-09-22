class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  before_action :find_microposts, only: :destroy


  def index
    @search_query = MicropostSearchService.new(params[:search])
    @microposts = @search_query.find.paginate(page: params[:page])
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost is created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end

  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content)
  end

  def find_microposts
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.present?
  end
end