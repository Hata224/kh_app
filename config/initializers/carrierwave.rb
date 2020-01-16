frozen_string_literal: true

require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AKIA25NGMTMVOFPOECSY'],
    aws_secret_access_key: ENV['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'],
    region: 'ap-northeast-1'
  }

  case Rails.env
  when 'development'
    config.fog_directory = 'rails-photo-01'
    config.asset_host = 'https://rails-photo-01.s3.amazonaws.com/'
  when 'production'
    config.fog_directory = 'rails-photo-01'
    config.asset_host = 'https://rails-photo-01.s3.amazonaws.com/'
  end

  config.fog_public     = true
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
end
CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
