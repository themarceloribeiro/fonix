class MessagesController < ApplicationController
  MESSAGE_CHANNEL_PREFIX = 'chat_channel_'.freeze

  before_action :find_group

  def index
    @message = Message.new(group_id: @group.try(:id))

    @messages = Message.includes(:author).where("created_at > ?", 1.week.ago)
    if @group.present?
      @messages = @messages.where(group_id: @group.id)
    else
      @messages = @messages.where(group_id: nil)
    end
  end

  def create
    @message = current_user.messages.new(message_params)
    if @message.valid?
      @message.save
      ActionCable.server.broadcast "#{MESSAGE_CHANNEL_PREFIX}#{@message.group_id}", {
        message: @message.body,
        author: @message.author.email,
        timestamp: @message.created_at.strftime('%b %a %d, %H:%M')
      }
    else
      render json: { errors: @message.errors.full_messages.join(', ') }, status: 422
    end
  end

  protected

  def find_group
    @group = current_user.groups.find(params[:group_id]) if params[:group_id].present?
  end

  def message_params
    params.require(:message).permit(:body, :group_id)
  end
end
