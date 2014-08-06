class CreateMessageService

  def initialize
  end

  def validate_params(params)
    @message = Message.new
    if params[:user_id].blank?
        @message.errors.add (:user_id)
    else
      @message.user_id = params[:user_id]
    end
    if params[:content].blank?
      @message.errors.add (:content)
    end
  end
end