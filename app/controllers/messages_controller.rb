class MessagesController < ApplicationController
  def index
    @messages = Message.includes(:author).where("created_at > ?", 1.week.ago)
  end

  def create
    @message = current_user.messages.new(message_params)
    if @message.valid?
      @message.save
      # ActionCable.server.broadcast("chat_channel", {one: 'two'})
    else
      render json: { errors: @message.errors.full_messages.join(', ') }, status: 422
    end
  end

  protected

  def message_params
    params.require(:message).permit(:body)
  end
end
