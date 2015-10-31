Rails.application.routes.draw do
  if ENV['IS_ADMIN_WEB'] == 'true' && !Rails.env.staging?
    # 管理画面用
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
    root 'admin/dashboard#index'

    # For AutoDeployment
    post 'api/deploy' => 'api#deploy'
  else
    # 外部向け用
    root 'static_pages#index'

    get   'about'   => 'static_pages#about'
    get   'rules'   => 'static_pages#rules'
    get   'how_to_vote' => 'static_pages#how_to_vote'
    get   'flow_chart'  => 'static_pages#flow_chart'
    get   'next'        => 'static_pages#next'
    get   'history'        => 'static_pages#history'
    get   'entrypolicy'    => 'static_pages#entrypolicy'
    get   'terms'    => 'static_pages#terms'
    get   'policy'   => 'static_pages#policy'

    get   'news'     => 'news#index'

    scope :contestants, as: :contestants do
      get   'entry' => 'contestants#entry'
      get   'thankyou_sample'    => 'contestants#thankyou_sample'
      get   'mypage_sample'      => 'contestants#mypage_sample'
      get   'new_interview_answer' => 'contestants#new_interview_answer'
      post  'create_interview_answer' => 'contestants#create_interview_answer'
      unless Rails.env.production?
        get   'group/:id'   => 'contestants#index'
        get   '/:id/mypage' => 'contestants#mypage'
        get   '/:id/thankyou' => 'contestants#thankyou', as: :thankyou
      end
    end

    resources :contestants, only: [:new, :create] do
      resource :vote, only: [:create] unless Rails.env.production?
    end

    unless Rails.env.production?
      resource :user, only: [:create] do
        resource :user_profile, path: 'profile', as: :profile
      end
      scope :users do
        get   'signup' => 'users#new'
        get   '/:id/activate' => 'users#activate', as: :activation
        get   'registration_completed' => 'users#registration_completed'
      end
      resources :password_resets
    end

    get "logout" => "user_sessions#destroy", :as => "logout"
    get "login" => "user_sessions#new", :as => "login"
    resources :user_sessions, only: :create

    # Sidekiqのステータス管理用
    # 接続元は，ローカルホスト及びAdminサーバのみに制限
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq', constraints: AdminServerConstraint

    # ステージングでは管理画面もマウントする
    if Rails.env.staging?
      # 管理画面用
      devise_for :admin_users, ActiveAdmin::Devise.config
      ActiveAdmin.routes(self)
    end
  end
end
