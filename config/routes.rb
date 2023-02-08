Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do
      get "/messages" => "messages#index"
      get "/messages/:id" => "messages#show"

      post "/messages" => "messages#create"
      patch "/messages/:id" => "messages#update"
      patch "/messages/:id/accept" => "messages#accept"
      patch "/messages/:id/reject" => "messages#reject"
      delete "/messages/:id" => "messages#destroy"
    end
  end
end
