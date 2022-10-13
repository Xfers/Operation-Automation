Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do
      get "/messages" => "messages#index"
      get "/messages/:id" => "messages#show"

      post "/messages" => "messages#create"
      patch "/messages/:id" => "messages#update"
      delete "/messages/:id" => "messages#destroy"
    end
  end
end
