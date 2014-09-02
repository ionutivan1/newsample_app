require 'spec_helper'

describe MessageService do

  let(:user) { FactoryGirl.create(:user, email: "exampleadmin@railstutorial.org") }
  describe "with valid params" do

    it "creates and saves message" do
      valid_params = {user_id: user.email, content: "blabla"}
      service = MessageService::CreateMessageService.new(valid_params, 1)
      expect { service.create_message }.to change(Message, :count).by(1)
      # expect(service.create_message).to be(true)
    end
  end

  describe "with invalid params" do

    it "does not create and save message" do
      invalid_params = {user_id: "", content: ""}
      service = MessageService::CreateMessageService.new(invalid_params, 1)
      service.create_message
      # expect(service.get_errors).not_to eq(nil)
      expect { service.create_message }.not_to change(Message, :count)
    end
  end

  describe "seen messages" do


    it "clicked on the message" do
      message = Message.new(id: 1, sender_id: 1, content: "veryspecifictestcontent", user_id: 1, seen: false)
      MessageService::SeenService.new(message)
      expect { message.seen }.to be_true
    end
  end
end


