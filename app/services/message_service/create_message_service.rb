module MessageService
  class CreateMessageService

    def initialize(params, receiver_id)
      @user_id = params[:user_id]
      @content = params[:content]
      @receiver_id = receiver_id
    end

    def save_message
      return new_message
    end

    private

    def new_message
      @message = Message.new
      @message.sender_id = @receiver_id
      @message.content = @content
      @message.user_id = get_user
      if @message.valid?
        return @message.save
      else
        return @message.errors.full_messages
      end
    end

    def get_user
      if User.find_by_email(@user_id).blank?
        return nil
      else
        return User.find_by_email(@user_id).id
      end
    end
  end
end