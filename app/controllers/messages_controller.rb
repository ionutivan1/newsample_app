class MessagesController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :destroy]

  def index

  end

  def new
    @message = Message.new
  end

  def show
    @messages = current_user.messages.paginate(page: params[:page])
  end

  def create
    @message_service = CreateMessageService.new
    if @message_service.validate_params(params[:message])
      @message = @message_service.new_message(params[:message], current_user.id)
    else
      flash[:notice] = "Fields are empty. Please fill them"
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
