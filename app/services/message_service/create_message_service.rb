module MessageService
  class CreateMessageService

    def initialize(params, receiver_id)
      @user_id = params[:user_id]
      @content = params[:content]
      @receiver_id = receiver_id
    end

    def create_message
      build_message
      save
    end

    def get_errors
      return @message.errors.full_messages
    end

    private

    def build_message
      @message = Message.new(sender_id: @receiver_id, content: @content, user_id: get_user)
    end

    def save

      if @message.valid?
        @message.save
      end
    end

    def get_user
      User.find_by_email(@user_id).try(:id)
    end

  end
end