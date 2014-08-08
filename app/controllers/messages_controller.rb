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
    @service = MessageService::CreateMessageService.new(params[:message], current_user.id)
    result = @service.save_message
    if result.nil?
      flash[:success] = "Message sent!"
    else
      result.each do |msg|
        flash[:notice] = msg
      end
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
