CarrierWave.configure do |config|

  # Cache dir under tmp for Heroku compatibility
  config.cache_dir = "#{Rails.root}/tmp/uploads"
  # config.root = Rails.root.join('tmp')
  # config.cache_dir = 'carrierwave'

  # Fog credentials for S3
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'AKIAJQBJASWITXRF3KLA',
    :aws_secret_access_key  => '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'
  }
  config.fog_directory  = "criticube-#{Rails.env}"
  config.fog_host       = "//criticube-#{Rails.env}.s3-website-us-east-1.amazonaws.com"
  config.fog_public     = true

end

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/