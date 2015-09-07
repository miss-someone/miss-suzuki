Rails.application.routes.draw do

  scope :contestants do
    get   'group/:id'   => 'contestants#index'
    get   'entry'       => 'contestants#entry'
    get   'new'         => 'contestants#new'
    post  'create'      => 'contestants#create'
    post  '/:id/vote'    => 'contestants#vote', as: :vote
  end

end
