if Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
  end
else
  CarrierWave.configure do |config|
  config.storage    = :aws
  config.aws_bucket = ENV['AMAZON_DIR']
  config.aws_acl    = 'public-read-write'

  # The maximum period for authenticated_urls is only 7 days.
  #config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7

  # Set custom options such as cache control to leverage browser caching
  #config.aws_attributes = {
    #expires: 1.week.from_now.httpdate,
    #cache_control: 'max-age=604800'
  #}

  config.aws_credentials = {
    access_key_id:     ENV['AMAZON_KEY'],
    secret_access_key: ENV['AMAZON_SECRET']
    #region:            ENV['AMAZON_REGION'], # Required
    #endpoint:          ENV['AMAZON_ENDPOINT']
    #host:              ENV['AMAZON_HOST']
  }

  # Optional: Signing of download urls, e.g. for serving private
  # content through CloudFront.
  #config.aws_signer = -> (unsigned_url, options) { Aws::CF::Signer.sign_url unsigned_url, options }
  end
end

