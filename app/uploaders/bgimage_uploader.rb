class BgimageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process :convert => 'png'
  process :tags => ['bgimage']

#  version :standard do
#    process :resize_to_fill => [100, 150, :north]
#  end
#
  version :thumbnail do
    process :resize_to_fit => [50, 50]
  end

  def public_id
    return - model.id
  end
end
