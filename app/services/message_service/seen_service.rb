module MessageService
  class SeenService

    def initialize(message)
      @message = message
      clicked?
    end

    def clicked?
      @message.seen = true
      @message.save
    end
  end
end