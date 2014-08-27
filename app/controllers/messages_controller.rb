class MessagesController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :destroy]

  def index
    @messages = current_user.messages.paginate(page: params[:page])
  end

  def new
    @message = Message.new
  end

  def show
    @message = Message.find(params[:id])
    # @microposts = @user.microposts.paginate(page: params[:page])
    # @messages = current_user.messages.paginate(page: params[:page])
  end

  def create
    @service = MessageService::CreateMessageService.new(params[:message], current_user.id)
    if @service.create_message
      flash[:success] = "Message sent!"
    else
      flash[:error] = @service.get_errors
    end
    redirect_to message_url(current_user)
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
