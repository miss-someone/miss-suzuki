# encoding: utf-8

class AdsUploader < CarrierWave::Uploader::Base
  include ::CarrierWave::Backgrounder::Delay
  include Cloudinary::CarrierWave

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # 画像リクエスト先サーバのホスト名を返す
  def img_server_host_name
    # Production時のみ，プロキシを介すようにする
    Rails.env.production? ? 'miss-suzuki.com' : 'res.cloudinary.com'
  end
end
