# frozen_string_literal: true

CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: 'AKIA25NGMTMVOFPOECSY',
    aws_secret_access_key: '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',
    region: 'ap-northeast-1'
  }

  config.fog_directory = 'rails-photo-01'
  config.cache_storage = :fog
end
