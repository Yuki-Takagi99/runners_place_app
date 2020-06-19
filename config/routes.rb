Rails.application.routes.draw do
  root to: 'other_pages#index'

  get 'privacy_policy', to: 'other_pages#privacy_policy'
  get 'terms_of_service', to: 'other_pages#terms_of_service'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions:      'users/sessions',
    passwords:     'users/passwords'
  }

  devise_scope :user do
    get 'users/index', to: 'users/registrations#index'
    get 'users/destroy', to: 'users/sessions#destroy'
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  resources :users, only: [:index, :show] do
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
