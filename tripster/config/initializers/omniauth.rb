OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
    provider :twitter, "4Lvn6SKPMm1mI9HgO4hA", "l4lNcfwdXu09T37ieQbM5m9dZ77USx3QRIEosHvMAo"
end

