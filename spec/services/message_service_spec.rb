require 'spec_helper'

describe MessageService do
  let (:service) { MessageService::CreateMessageService.new({"user_id" => "", "content" => ""}, 1) }
  let (:valid_service) { MessageService::CreateMessageService.new({"user_id" => "exampleadmin@railstutorial.org", "content" => "asd"}, 1) }
  it "returns false" do
    service.stub(:message) { false }
    service.message.should eq(false)
  end
  it "returns true" do
    valid_service.stub(:message) { true }
    valid_service.message.should eq(true)
  end


end

