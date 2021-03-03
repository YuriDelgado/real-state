Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :realstates, only: %I[index create show update delete]
    end
  end
end
