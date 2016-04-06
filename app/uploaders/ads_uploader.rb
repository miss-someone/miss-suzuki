# encoding: utf-8

class AdsUploader < CarrierWave::Uploader::Base
  include ::CarrierWave::Backgrounder::Delay
  include Cloudinary::CarrierWave

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def url
    return if file.nil?
    # 行が長くなりすぎる為，改行を行っているのでrubocopを一部無視
    # rubocop:disable Style/SpaceAroundOperators
    "https://#{img_server_host_name}/#{Cloudinary.config.cloud_name}/"\
    + "#{file.resource_type}/upload/"\
    + "/v#{file.version}/#{file.filename}"
    # rubocop:enable all
  end

  # 画像リクエスト先サーバのホスト名を返す
  def img_server_host_name
    # Production時のみ，プロキシを介すようにする
    # Rails.env.production? ? 'miss-suzuki.com' : 'res.cloudinary.com'
    # Herokuに移すので，Cloudinaryへアクセスするようにした 
    'res.cloudinary.com'

  end
end
