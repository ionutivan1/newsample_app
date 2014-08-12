require 'spec_helper'

describe Message do
  let(:user) { FactoryGirl.create(:user) }
  before { @message = user.messages.build(content: "Lorem ipsum", user_id: user.id) }

  subject { @message }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }

  describe "with blank content" do
    before { @message.content = "" }
    it { should_not be_valid }
  end

  describe "with content" do
    before { @message.content = "asd", @message.sender_id = user.id }
    it { should be_valid }
  end

  describe "with blank user_id" do
    before { @message.user_id = "" }
    it { should_not be_valid }
  end

  #or this?

  describe "when user_id is not present" do
    before { @message.user_id = nil }
    it { should_not be_valid }
  end

  describe "with user_id" do
    before { @message.user_id = user.id }
    before { @message.sender_id = user.id }
    it { should be_valid }
  end
end
