Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               sessions: 'users/sessions'
               # registrations: 'users/registrations'  # Uncomment if you have custom signup
             },
             path: '',
             path_names: {
               sign_in: 'login',      # POST /login
               sign_out: 'logout'     # DELETE /logout
             }

  namespace :api do
    namespace :v1 do
      post 'auth/login', to: 'auth#login'
      resources :schools, only: [:index, :create, :update]
      resources :courses, only: [:index, :create]
      resources :batches, only: [:index, :create]
      resources :enrollment_requests, only: [:create, :update]  # update for approve/deny
      get 'batches/:batch_id/classmates', to: 'student_batches#index'
      # Add school_admins create if admin needs to create them
      resources :school_admins, only: [:create]  # Admin creates SchoolAdmin
    end
  end
end