module MessageService
  class CreateMessageService

    def initialize(params)
      #initialize nu returneaza ever
      @user_id = params[:user_id]
      @content = params[:content]
    end

    def save_message(current_user_id)
      if self.validate_params(@user_id, @content)
        result = self.new_message(@user_id, @content, current_user_id)
        return result
      end
    end

    def validate_params(user_id, content)
      if user_id.blank? || content.blank?
        return false
      else
        return true
      end
    end

    def new_message(user_id, content, current_user_id)
      @message = Message.new
      @message.sender_id = current_user_id
      @message.user_id = User.find_by_email(user_id).id
      @message.content = content
      if @message.valid?
        @message.save
        return true
      else
        return false
      end
    end

  end
end