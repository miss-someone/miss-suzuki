# /errbit以下でerrbitを動かしているので，POST先のURLを修正するモンキーパッチ
module Airbrake
  class Sender
    remove_const(:NOTICES_URI)
    remove_const(:JSON_API_URI)
    NOTICES_URI = '/errbit/notifier_api/v2/notices'.freeze
    JSON_API_URI = '/api/v3/projects'.freeze
  end
end
