require 'spec_helper'

describe PhotoWriter do
  before(:all) do
    User.from_omniauth(OmniAuth.config.mock_auth[:twitter])
    PhotoStub = Struct.new(:id, :images, :caption, :created_time)
    ImageStub = Struct.new(:thumbnail, :standard_resolution)
    UrlStub = Struct.new(:url)
    CaptionStub = Struct.new(:text)
  end
  let(:user) { User.last }
  let(:access_token) { "272988880.5b6e183.bbb6419c1f934ff79e23d9192276f4a6" }
  let(:client) { PhotoWriter.client(access_token) }


  it "can connect to Instgram Client" do
    expect(client).to_not be_nil
  end

  let(:photos) do
    [PhotoStub.new("abc123",
		   ImageStub.new(
		     UrlStub.new("/link"), UrlStub.new("example.com/stuff")),
		   CaptionStub.new("test"),
		   DateTime.now.to_i.to_s),
     PhotoStub.new("abc124",
		   ImageStub.new(
		     UrlStub.new("/link"), UrlStub.new("example.com/stuff")),
		   CaptionStub.new("test"),
		   DateTime.now.to_i.to_s)]
  end

  it "can store photos" do
    client.stub(:user_recent_media) { photos }

    responses = PhotoWriter.store_photos(client, user.id)
    responses.each do |response|
      expect(response.body).to include "201"
      expect(response.body).not_to include "400"
    end
  end
end
