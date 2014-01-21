require 'spec_helper'

describe StatusWriter do
  before(:all) do
    User.from_omniauth(OmniAuth.config.mock_auth[:twitter])
    StatusStub = Struct.new(:full_text, :created_at)
  end

  let(:user) { User.last }
  let(:week) { 7*24*60*60 }
  let(:client) do
    StatusWriter.client("oauth_token" =>  user.access_token,
			"oauth_token_secret" =>  user.access_secret)
  end

  let(:statuses) do
    [StatusStub.new("Daft Punk is playing at my house",
		     DateTime.now),
     StatusStub.new("New York I love you, but...",
		     DateTime.now - 2 * week)]
  end

  it "should be able to call the twitter client" do
    expect(client).to be_an_instance_of Twitter::Client
    expect(client.user.user_name.downcase).to eq user.name
  end

  it "should be able to write current statuses between a date range" do
    client.stub(:user_timeline) { statuses }
    responses = StatusWriter.store_statuses(client, user.id, DateTime.now - week, DateTime.now + week)
    responses.each do |response|
      expect(response.body).to include "201"
    end
  end
end
