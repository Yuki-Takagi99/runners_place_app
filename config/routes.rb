Rails.application.routes.draw do
  devise_for :users
  root to: 'practice_diaries#index'
  resources :practice_diaries
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
