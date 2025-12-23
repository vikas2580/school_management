Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      post 'auth/login', to: 'auth#login'
      resources :schools, only: [:index, :create, :update]
      resources :courses, only: [:index, :create]
      resources :batches, only: [:index, :create]
      resources :enrollment_requests, only: [:create, :update]  # update for approve/deny
      get 'batches/:batch_id/classmates', to: 'student_batches#index'
      
      resources :school_admins, only: [:create]
    end
  end
end