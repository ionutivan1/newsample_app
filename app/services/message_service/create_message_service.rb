module MessageService
  class CreateMessageService

    def initialize(params, receiver_id)
      @user_id = params[:user_id]
      @content = params[:content]
      @receiver_id = receiver_id
      @params = params
    end

    def create_message
      save_message
      set_additional_params
    end

    def get_errors
      return @message.errors.full_messages
    end

    private

    def save_message
      @message = Message.create(@params)

    end

    def set_additional_params
      @message.user_id = get_user
      @message.sender_id = @receiver_id
      @message.seen = false
      if @message.valid?
        @message.save
        UserMailer.message_notification(get_user).deliver
      end
    end

    def get_user
      User.find_by_email(@user_id).try(:id)
    end

  end
end