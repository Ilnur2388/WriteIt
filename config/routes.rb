Rails.application.routes.draw do
  get 'search', to: "search#index"
    resource :session, only: %i[new create destroy]

    resources :users, only: %i[new create edit update]
    resources :posts, except: :show

    namespace :admin do
        resources :users, only: %i[index create edit update destroy]
        resources :posts, only: %i[index edit update destroy]
    end

    root 'pages#index'
end
