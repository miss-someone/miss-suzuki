Rails.application.routes.draw do
  root 'static_pages#index'

  get   'about'   => 'static_pages#about'
  get   'news'    => 'static_pages#news'
  get   'rules'   => 'static_pages#rules'
  get   'how_to_vote' => 'static_pages#how_to_vote'
  get   'flow_chart'  => 'static_pages#flow_chart'
  get   'next'        => 'static_pages#next'

  scope :contestants do
    get   'group/:id'   => 'contestants#index'
    get   'entry'       => 'contestants#entry'
    get   'new'         => 'contestants#new'
    post  'create'      => 'contestants#create'
    post  '/:id/vote'   => 'contestants#vote', as: :vote
  end
end
