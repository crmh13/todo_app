class AvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process :convert => 'png'
  process :tags => ['avatar']

  version :standard do
    process :resize_to_fill => [250, 250, :north]
  end

  version :thumbnail do
    process :resize_to_fit => [80, 80]
  end

  def public_id
    return model.id
  end
end
