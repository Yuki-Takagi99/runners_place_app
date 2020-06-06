Rails.application.routes.draw do
  root to: 'practice_diaries#index'
  devise_for :users
  resources :users, only: [:show]
  resources :practice_diaries

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
