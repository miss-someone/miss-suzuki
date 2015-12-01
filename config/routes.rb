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
    get   'history'        => 'contents#history' # 旧urlもcontentへリダイレクト
    get   'entrypolicy'    => 'static_pages#entrypolicy'
    get   'terms'    => 'static_pages#terms'
    get   'policy'   => 'static_pages#policy'
    get   'help' => 'static_pages#help'
    get   'contents' => 'contents#index'
    get   'contents/history' => 'contents#history'
    get   'contents/erai_suzukisan1' => 'contents#interview1'
    get   'contents/erai_suzukisan1_2' => 'contents#interview1_2'
    get   'contents/erai_suzukisan_sp1' => 'contents#interview_sp1'
    get   'news' => 'news#index'

    scope :contestant_image do
      get 'new' => 'contestant_image#new'
      post 'create' => 'contestant_image#create'
      patch 'create' => 'contestant_image#create'
      get   'edit' => 'contestant_image#edit'
      post  'destroy' => 'contestant_image#destroy'
    end

    scope :contestants, as: :contestants do
      get   'entry' => 'contestants#entry'
      get   'thankyou_sample'    => 'contestants#thankyou_sample'
      get   'mypage_sample'      => 'contestants#mypage_sample'
      get   'new_interview_answer' => 'contestants#new_interview_answer'
      post  'create_interview_answer' => 'contestants#create_interview_answer'
      get   'group/:id' => 'contestants#index'
      get   'second_stage' => 'contestants#second_stage'
      get   '/:id/mypage' => 'contestants#mypage', as: :mypage
      get   'my_own_page' => 'contestants#my_own_page'
      get   '/:id/thankyou' => 'contestants#thankyou', as: :thankyou
    end

    resources :contestants, only: [:new, :create] do
      resource :vote, only: [:create]
    end

    resource :user, only: [:create] do
      resource :user_profile, except: [:destroy], path: 'profile', as: :profile
      get   'password_edit' => 'password_edits#edit'
      post  'password_update' => 'password_edits#update'
    end
    scope :users do
      get   'signup' => 'users#new'
      get   '/:id/activate' => 'users#activate', as: :activation
      get   'registration_completed' => 'users#registration_completed'
    end
    resources :password_resets, only: [:new, :create, :edit, :update]

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
