module MessageService
  class CreateMessageService

    def initialize(params, receiver_id)
      @user_id = params[:user_id]
      @content = params[:content]
      @receiver_id = receiver_id
    end

    def save_message
      new_message
        if @message.valid?
          @message.save
          return true
        else
          return false
        end
    end

    def get_errors
      return @message.errors.full_messages
    end

    private

    def new_message
      @message = Message.new
      @message.sender_id = @receiver_id
      @message.content = @content
      @message.user_id = get_user
      return @message
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