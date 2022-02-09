require 'rails_helper'

describe MessagesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:group) { FactoryBot.create(:group) }

  describe "POST create" do
    before do
      request.env['warden'] = double(
        Warden,
        :authenticate => user,
        :authenticate! => user,
        :authenticate? => true
      )
    end

    it "creates a new message" do
      post :create, params: { message: { group_id: group.id, body: 'something nice' } }, format: :js
      expect(Message.count).to eql(1)
      expect(Message.last.author).to eql(user)
      expect(Message.last.group).to eql(group)
    end

    it "broadcast the message to the channel" do
      expect_any_instance_of(ActionCable::Server::Base).to receive(:broadcast).with(
        "#{MessagesController::MESSAGE_CHANNEL_PREFIX}#{group.id}",
        {
          message: 'something nice',
          author: user.email,
          timestamp: Time.now.utc.strftime('%b %a %d, %H:%M')
        }
      )

      post :create, params: { message: { group_id: group.id, body: 'something nice' } }, format: :js
    end
  end
end
