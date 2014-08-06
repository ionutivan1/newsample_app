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
    @message_service = CreateMessageService.new
    @message_service.validate_params(params[:message])

    # email = params[:message][:user_id]
    # content = params[:message][:content]
    #
    # if email.blank? ||content.blank?
    #   flash[:notice] = "Fields are empty. Please fill them"
    #   redirect_to message_url(current_user) and return
    # else
    # @message = Message.create(message_params)
    #   @message.sender_id = current_user.id
    #   @message.user_id = User.find_by_email(email).id
      if @message.save
        flash[:success] = "Message sent!"
        redirect_to message_url(current_user)
      else
        render 'messages/show'
      end
    # end
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
