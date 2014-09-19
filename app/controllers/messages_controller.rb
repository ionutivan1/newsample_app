class MessagesController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :destroy]
  before_action :find_message, only: [:show,:destroy]

  def index
    @messages = current_user.messages.paginate(page: params[:page])
  end

  def new
    @message = Message.new
  end

  def show
    MessageService::SeenService.new(@message)
  end

  def create
    @service = MessageService::CreateMessageService.new(message_params, current_user.id)
    if @service.create_message
      flash[:success] = "Message sent!"
    else
      flash[:error] = @service.get_errors
    end
    redirect_to messages_url(current_user)
  end

  def destroy
    @message.destroy
    redirect_to messages_url(current_user)
  end

  private

  def find_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:user_id, :content, :sender_id, :mes_attach)
  end

end
