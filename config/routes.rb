Rails.application.routes.draw do
  root 'static_pages#index'

  get   'about'   => 'static_pages#about'
  get   'news'    => 'static_pages#news'
  get   'rules'   => 'static_pages#rules'
  get   'how_to_vote' => 'static_pages#how_to_vote'
  get   'flow_chart'  => 'static_pages#flow_chart'
  get   'next'        => 'static_pages#next'
  get   'entrypolicy'    => 'static_pages#entrypolicy'
  get   'terms'    => 'static_pages#terms'
  get   'policy'   => 'static_pages#policy'

  scope :contestants do
    get   'entry'       => 'contestants#entry'
    get   'new'         => 'contestants#new'
    get   'thankyou'    => 'contestants#thankyou'
    get   'mypage'      => 'contestants#mypage'
    post  'create'      => 'contestants#create'
    if Rails.env.development?
      get   'group/:id'   => 'contestants#index'
      post  '/:id/vote'   => 'contestants#vote', as: :vote
    end
  end

  # 管理画面用
  if ENV['IS_ADMIN_WEB'] == 'true'
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
  end
end
