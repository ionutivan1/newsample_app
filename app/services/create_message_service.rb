class CreateMessageService

  def initialize
  end

  def validate_params(params)
    if params[:user_id].blank? || params[:content].blank?
      return false
    else
      return true
    end
  end

  def new_message(params, current_user_id)
    @message = Message.new
    @message.sender_id = current_user_id
    @message.user_id = User.find_by_email(params[:user_id]).id
    @message.content = params[:content]
    return @message
  end
end