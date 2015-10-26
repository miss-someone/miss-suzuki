Rails.application.routes.draw do
  if ENV['IS_ADMIN_WEB'] == 'true'
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

    scope :contestants do
      get   'entry'       => 'contestants#entry'
      get   'new'         => 'contestants#new'
      get   'thankyou'    => 'contestants#thankyou_sample'
      get   'mypage'      => 'contestants#mypage_sample'
      post  'create'      => 'contestants#create'
      get   'new_interview_answer' => 'contestants#new_interview_answer'
      post 'create_interview_answer' => 'contestants#create_interview_answer'
      if Rails.env.development?
        get   'group/:id'   => 'contestants#index'
        post  '/:id/vote'   => 'contestants#vote', as: :vote
        get   '/:id/mypage' => 'contestants#mypage'
        get   '/:id/thankyou' => 'contestants#thankyou'
      end
    end

    if Rails.env.development? || Rails.env.test?
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

  end
end
