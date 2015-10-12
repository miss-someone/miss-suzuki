# Be sure to restart your server when you modify this file.

# Rails.application.config.session_store :cookie_store, key: '_miss-suzuki_session'
Rails.application.config.session_store ActionDispatch::Session::CacheStore, expire_after: 1.month
