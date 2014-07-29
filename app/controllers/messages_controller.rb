class MessagesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def index

  end

  def show
    @user = User.find(params[:id])
    @messages = @user.messages.paginate(page: params[:page])
  end

  def create
    if @message.save
        #un something
    else
      # render 'static_pages/home'
    end
  end

  def destroy
    @message.destroy
    redirect_to root_url
  end

end
