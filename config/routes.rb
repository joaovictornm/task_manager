Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :tasks do
    post 'change_status', on: :member
    post 'create_comment', on: :member
  end

  resources :user_tasks, only: [:index]
  get 'task_report', to: 'user_tasks#task_report', as: 'user_task_report'

  resources :profiles, only: %i[show new create update edit] do
    get 'private_page', on: :member
    post 'change_privacy', on: :member
    resources :comments, only: %i[index]
  end

  resources :comments, only: [:destroy]

  resources :pluses, only: %i[create destroy]
  resources :minuses, only: %i[create destroy]
end
