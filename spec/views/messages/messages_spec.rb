require 'spec_helper'

describe "Notifications" do

  let(:user) { FactoryGirl.create(:user) }
  before(:each) do
    sign_in user
  end

  context "with no messages" do
    it "should display 0" do
      expect(page).to have_content("Notifications(0)")
    end

  end
  context "with unread messages" do
    before do
      valid_params = {user_id: user.email, content: "blabla"}
      fake_message = MessageService::CreateMessageService.new(valid_params, 1)
      fake_message.create_message
      visit messages_path
    end
    it "should display 1" do
      expect(page).to have_content("Notifications(1)")
    end

  end
end
