module MessageService
  class CreateMessageService

    # include ActiveModel::Validations

    #could have validations like this
    # attr_accessor :user_id, :content
    #
    # validates_presence_of :user_id, on: :new_message, message: "No email here"
    # validates_presence_of :content, on: :new_message, message: "No content here"

    #or like this
    # validate :message_validator, on: :new_message


    def initialize(params, receiver_id)
      @user_id = params[:user_id]
      @content = params[:content]
      @receiver_id = receiver_id
    end

    def create_message
      new_message
      save_if_valid
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
    end

    def save_if_valid

      if @message.valid?
        @message.save
        return true
      else
        return false
      end
    end

    def get_user
      if User.find_by_email(@user_id).blank?
        return nil
      else
        return User.find_by_email(@user_id).id
      end
    end

    # def message_validator
    #   call validator class from here
    #   validates_with MessageService::MyValidator
    # end
  end
  # class MyValidator
  #   do validations here
  #   include ActiveModel::Validations
  # validates_presence_of :user_id, on: :new_message, message: "No email here"
  # validates_presence_of :content, on: :new_message, message: "No content here"
  # end
end