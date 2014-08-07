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
    @service = MessageService::CreateMessageService.new(params[:message])
    if @service.save_message(current_user.id)
      flash[:success] = "Message sent!"
    else
      flash[:notice] = "There were issues"
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
