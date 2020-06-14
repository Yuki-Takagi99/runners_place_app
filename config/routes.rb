Rails.application.routes.draw do
  root to: 'practice_diaries#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users, only: [:show] do
    member do
      get :following, :followers
    end
  end

  resources :friendships, only: [:create, :destroy]

  resources :practice_diaries do
    resources :practice_comments, only: [:create, :destroy, :edit, :update]
    resource :practice_favorites, only: [:create, :destroy]
    collection do
      get 'index_all'
    end
  end

  resources :events

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
