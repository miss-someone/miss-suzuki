Rails.application.routes.draw do
  if ENV['IS_ADMIN_WEB'] == 'true' && !Rails.env.staging?
    # 管理画面用
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
    root 'admin/dashboard#index'

    # For AutoDeployment
    post 'api/deploy' => 'api#deploy'
    post 'api/reborn/:id' => 'api#reborn'
  else
    # 外部向け用
    root 'static_pages#index'

    get   'final'   => 'static_pages#final'
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
    get   'contents/erai_suzukisan2_1' => 'contents#interview2_1'
    get   'contents/erai_suzukisan2_2' => 'contents#interview2_2'
    get   'contents/erai_suzukisan3' => 'contents#interview3'
    get   'contents/akaji' => 'contents#akaji'
    get   'contents/fujishiro' => 'contents#fujishiro'
    get   'contents/erai_suzukisan4' => 'contents#interview4'
    get   'contents/erai_suzukisan5' => 'contents#interview5'
    get   'contents/erai_suzukisan6' => 'contents#interview6'
    get   'contents/erai_suzukisan7' => 'contents#interview7'
    get   'contents/erai_suzukisan8' => 'contents#interview8'
    get   'contents/report' => 'contents/report'
    get   'news' => 'news#index'
    get   'idols' => 'idols#index'
    get   'idols/info' => 'idols#info'
    get   'idols/entry' => 'idols#entry'
    post  'idols/confirm' => 'idols#confirm'
    post  'idols/create' => 'idols#create'
    post  'idols/thankyou' => 'idols#thankyou'

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
      get   'semifinal' => 'contestants#semifinal'
      get   'suzukike' => 'contestants#suzukike'
      get   'tshirt' => 'contestants#tshirt'
      get   '/:id/mypage' => 'contestants#mypage', as: :mypage
      get   'my_own_page' => 'contestants#my_own_page'
      get   '/:id/thankyou' => 'contestants#thankyou', as: :thankyou
    end

    # resources :contestants, only: [:new, :create] do
    #   resource :vote, only: [:create]
    # end

    # resource :user, only: [:create] do
    #   resource :user_profile, except: [:destroy], path: 'profile', as: :profile
    #   get   'password_edit' => 'password_edits#edit'
    #   post  'password_update' => 'password_edits#update'
    # end
    scope :users do
      get   'signup' => 'users#new'
      get   '/:id/activate' => 'users#activate', as: :activation
      get   'registration_completed' => 'users#registration_completed'
    end
    # resources :password_resets, only: [:new, :create, :edit, :update]
    #
    get "logout" => "user_sessions#destroy", :as => "logout"
    get "login" => "user_sessions#new", :as => "login"
    # resources :user_sessions, only: :create

=begin
終わったので塞ぎます．
    namespace 'mister' do
      get   '/'       => 'static_pages#index'
      get   'index'   => 'static_pages#index'
      get   'about'   => 'static_pages#about'
      get   'rules'   => 'static_pages#rules'
      get   'how_to_vote' => 'static_pages#how_to_vote'
      get   'flow_chart'  => 'static_pages#flow_chart'
      get   'next'        => 'static_pages#next'
      get   'terms' => 'static_pages#terms'
      get   'entrypolicy' => 'static_pages#entrypolicy'

      scope :contestants, as: :contestants do
        get 'thankyou_sample' => 'contestants#thankyou_sample'
      end

      resource :contestants, only: [:new, :create] do
        get 'entry' => 'contestants#entry'
      end
    end
=end

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
