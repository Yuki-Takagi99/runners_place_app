Rails.application.routes.draw do
  root to: 'practice_diaries#index'
  resources :practice_diaries
end
