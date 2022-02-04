require 'rails_helper'

describe WeeklyMailerWorker do
  before do
    @user = FactoryBot.create(:user)
    @message = FactoryBot.create(:message, created_at: '2022-01-30')
    @message = FactoryBot.create(:message, author: @user, created_at: '2022-01-29')
    @message = FactoryBot.create(:message, created_at: '2022-01-28')
  end

  it 'should send the weekly report to the user' do
    Timecop.freeze '2022-02-01' do
      expect(WeeklyMailer).to receive(:weekly_summary).with(
        @user.id,
        '2022-01-29',
        1,
        3
      ).and_call_original

      WeeklyMailerWorker.new.perform(@user.id, '2022-01-29', 3)
    end
  end
end
