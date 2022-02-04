require 'rails_helper'

describe WeeklyMailerWorker do
  before do
    @user = FactoryBot.create(:user)
    @message = FactoryBot.create(:message, author: @user, created_at: '2022-01-30')
    @message = FactoryBot.create(:message, author: @user, created_at: '2022-01-29')
    @message = FactoryBot.create(:message, author: @user, created_at: '2022-01-28')
  end

  it 'should send the weekly report to the users batch' do
    Timecop.freeze '2022-02-01' do
      expect(WeeklyMailerWorker).to receive(:perform_async).with(
        @user.id,
        Time.parse('2022-01-30 00:00:00 UTC'),
        3
      ).at_least(:once).and_call_original

      WeeklyMailerBatchWorker.new.perform
    end
  end
end
