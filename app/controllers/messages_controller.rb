class MessagesController < ApplicationController
  MESSAGE_CHANNEL = 'chat_channel'.freeze

  def index
    @messages = Message.includes(:author).where("created_at > ?", 1.week.ago)
  end

  def create
    @message = current_user.messages.new(message_params)
    if @message.valid?
      @message.save
      ActionCable.server.broadcast MESSAGE_CHANNEL, {
        message: @message.body,
        author: @message.author.email,
        timestamp: @message.created_at.strftime('%b %a %d, %H:%M')
      }
    else
      render json: { errors: @message.errors.full_messages.join(', ') }, status: 422
    end
  end

  protected

  def message_params
    params.require(:message).permit(:body)
  end
end
