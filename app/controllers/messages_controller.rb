class MessagesController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :destroy]

  def index

  end

  def new
    @message = Message.new
  end

  def show
    @user = current_user
    @messages = @user.messages.paginate(page: params[:page])
  end

  def create
    @message = Message.new(message_params)
    @message.sender_id = current_user.id
    if params[:message][:user_id].blank?
      flash[:notice] = "Can't send it to no one! Input an email address please."
      redirect_to message_url(current_user) and return
    else
      @message.user_id = User.find_by_email(params[:message][:user_id]).id
    end
    if params[:message][:content].blank?
      flash[:notice] = "Content cannot be empty."
      redirect_to message_url(current_user) and return
    end
    if @message.save
      flash[:success] = "Message sent!"
      redirect_to message_url(current_user)
    else
      render 'messages/show'
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to message_url(current_user)
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :content, :sender_id)
  end

end
