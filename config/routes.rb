Rails.application.routes.draw do
  get 'user_sessions/new'

  if ENV['IS_ADMIN_WEB'] == 'true'
    # 管理画面用
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
    root 'admin/dashboard#index'
  else
    # 外部向け用
    root 'static_pages#index'

    get   'about'   => 'static_pages#about'
    get   'rules'   => 'static_pages#rules'
    get   'how_to_vote' => 'static_pages#how_to_vote'
    get   'flow_chart'  => 'static_pages#flow_chart'
    get   'next'        => 'static_pages#next'
    get   'entrypolicy'    => 'static_pages#entrypolicy'
    get   'terms'    => 'static_pages#terms'
    get   'policy'   => 'static_pages#policy'

    get   'news'     => 'news#index'

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

    get "logout" => "user_sessions#destroy", :as => "logout"
    get "login" => "user_sessions#new", :as => "login"
    # get "signup" => "users#new", :as => "signup"
    resources :users, only: [:new, :create, :destroy]
    resources :user_sessions, only: [:new, :create, :destroy]
    # get "secret" => "home#secret", :as => "secret"

  end
end
