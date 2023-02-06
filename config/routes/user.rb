Rails.application.routes.draw do
  scope module: :user do
    resources :campaigns, only: %i[show] do
      resources :applications, only: %i[create] do
        get :complete, on: :collection
      end
    end
  end
end
