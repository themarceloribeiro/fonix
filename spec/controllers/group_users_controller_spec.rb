require 'rails_helper'

describe GroupUsersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:user_b) { FactoryBot.create(:user) }
  let(:group) { FactoryBot.create(:group) }
  let(:group_user) { FactoryBot.create(:group_user, user: user, group: group) }

  before do
    request.env['warden'] = double(
      Warden,
      :authenticate => user,
      :authenticate! => user,
      :authenticate? => true
    )
  end

  it 'should create a new group user' do
    group_user
    post :create, params: { group_id: group.id, user_id: user_b.id }
    expect(response).to have_http_status(:redirect)
    expect(GroupUser.count).to eql(2)
    expect(GroupUser.last.user).to eql(user_b)
  end
end
