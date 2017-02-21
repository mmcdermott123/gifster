Rails.application.routes.draw do

  get 'relationships/follow_user'

  get 'relationships/unfollow_user'

  post ':name/follow_user', to: 'relationships#follow_user', as: :follow_user

  post 'name/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user

  get 'tags/:tag', to: 'links#index', as: :tag
  devise_for :users
  resources :users do
    member do
      get :links
      get :followers
      get :following
    end
  end

resources :categorys do
  member do
    get :links
  end
end

  resources :links do
    member do
      get "like", to: "links#upvote"
      get "dislike", to: "links#downvote"
      match 'links/:id' => 'links#download', :as => :download, via: [:get, :link]
    end
    resources :comments
  end

  resources :relationships, only: [:create, :destroy]

  root "links#index"
end
