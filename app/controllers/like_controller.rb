class LikeController <ApplicationController

  def create
    @message = Message.find(params[:message_id])
    @message.update_attributes(:liked => true)
    respond_to do |format|
        format.html { redirect_to @message }
      format.js {}
    end
  end

  def update
    @message = Message.find(params[:id])
    @message.update_attributes(:liked => false)
    respond_to do |format|
        format.html { redirect_to @message }
      format.js {}
    end
  end
end

