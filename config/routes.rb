Rails.application.routes.draw do
  root to: 'practice_diaries#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users, only: [:show]
  resources :practice_diaries do
    collection do
      get 'index_all'
    end
  end


  resources :practice_favorites, only: [:create, :destroy]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
