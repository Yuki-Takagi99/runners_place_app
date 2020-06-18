Rails.application.routes.draw do
  root to: 'other_pages#index'

  get 'privacy_policy', to: 'other_pages#privacy_policy'
  get 'terms_of_service', to: 'other_pages#terms_of_service'

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

  resources :events do
    resources :event_comments, only: [:create, :destroy, :edit, :update]
    resource :participant_managements, only: [:create, :destroy]
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
