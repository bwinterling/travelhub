OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
    provider :twitter, ENV["TWITTER_CONSUMER_KEY"], ENV["TWITTER_CONSUMER_SECRET"]
    # provider :instagram, "08c5fc73059f43a3a9e7b9b974bdcbc6", "6ebffaa1d75f49658591747f56ce0225"
    # prodiver :foursquare, "JSDQ5ZJ454QNOPXQXUNLU1SPJRKYP4OJUAQTK2DAIHEDIXC0", "4PDMRSFYT5CCJ5DWSFWA3ZEDTVT2DZUXLM1TVSHGNTGCULGM"
end

