CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     Rails.application.credentials.aws[:access_key_id],
      aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key],
      region: 'us-west-1'

  }
  config.fog_directory = Rails.application.credentials.aws[:bucket_name]
  config.fog_public = true
  config.fog_use_ssl_for_aws = false
  config.cache_dir = "#{Rails.root}/tmp/uploads"
end