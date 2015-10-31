# encoding: utf-8

class ContestantProfileImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  include ::CarrierWave::Backgrounder::Delay
  include Cloudinary::CarrierWave

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  # def store_dir
  #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # end

  # def public_id
  #   model.short_name
  # end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb do
    process convert: 'jpg'
    process :thumb_crop
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  def thumb_crop
    { x: model.profile_image_crop_param_x,
      y: model.profile_image_crop_param_y,
      width: model.profile_image_crop_param_width,
      height: model.profile_image_crop_param_height,
      crop: :crop
    }
  end

  # 画像をクロップするいい方法が見つからなかったため，urlをハードコードしてクロップ
  def thumb(width = 500, height = 500, is_blur = false)
    # 行が長くなりすぎる為，改行を行っているのでrubocopを一部無視
    # rubocop:disable Style/SpaceAroundOperators
    "https://res.cloudinary.com/#{Cloudinary.config.cloud_name}/"\
    + "#{file.resource_type}/upload/"\
    + "#{blur_param(is_blur, model)}"\
    + "#{extra_param(model)}"\
    + "c_crop,h_#{model.profile_image_crop_param_height},"\
    + "w_#{model.profile_image_crop_param_width},"\
    + "x_#{model.profile_image_crop_param_x},"\
    + "y_#{model.profile_image_crop_param_y}/"\
    + "c_fill,w_#{width},h_#{height}/v#{file.version}/#{file.filename}"
    # rubocop:enable all
  end

  # blurのかかったサムネイルを取得する
  def thumb_with_blur(width = 500, height = 500)
    thumb(width, height, true)
  end

  private

  # モデルにextra_paramが設定されている場合は/を追加して返す
  def extra_param(model)
    extra_param = model.profile_image_crop_param_extra
    extra_param.empty? ? '' : "#{extra_param}/"
  end

  # blurのパラメタを必要であれば返す
  def blur_param(is_blur, model)
    param = model.profile_image_blur_param
    param = Settings.contestant[:default_blur] if param == 0
    is_blur ? "e_blur:#{param}/" : ''
  end
end
