require 'rails_helper'

describe GroupsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
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

  it 'should create a new group' do
    post :create, params: { group: { name: 'Test Group' } }
    expect(response).to have_http_status(:redirect)
    expect(Group.count).to eql(1)
    expect(Group.first.name).to eql('Test Group')
  end

  it 'should return the group when vising show' do
    group_user
    get :show, params: { id: group.id }
    expect(response.status).to eql(200)
  end

  it 'should not return the group when vising show if user is not from that group' do
    get :show, params: { id: group.id }
    expect(response.status).to eql(404)
  end
end
