class CardAvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process resize_to_fit: [360, 360]

  def default_url
    ActionController::Base.helpers.asset_path('placeholder.png')
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
