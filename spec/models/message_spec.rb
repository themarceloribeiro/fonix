require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:user_a) { FactoryBot.create(:user) }
  let(:user_b) { FactoryBot.create(:user) }
  let(:group) { FactoryBot.create(:group) }
  let(:group_user_a) { FactoryBot.create(:group_user, group: group, user: user_a) }

  before do
    group_user_a
  end

  it 'should be valid when author is from that group' do
    @message = Message.new(group_id: group.id, author_id: user_a.id, body: 'hello')
    expect(@message).to be_valid
  end

  it 'should not be valid if author is not from that group' do
    @message = Message.new(group_id: group.id, author_id: user_b.id, body: 'hello')
    expect(@message).to_not be_valid
  end
end
