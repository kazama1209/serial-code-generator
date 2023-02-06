Rails.application.routes.draw do
  devise_for :admin, skip: %i[registrations password], controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    root "campaigns#index"
    
    resources :users, only: %i[edit update]
    resources :campaigns, only: %i[index new create edit update] do
      resources :venues, only: %i[index new create edit update]
      resources :serial_codes, only: %i[index new create edit update destroy]
      resources :applications, only: %i[index]
    end
  end
end
