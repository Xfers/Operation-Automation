Rails.application.routes.draw do
  get "welcome" => "welcome"
  get "welcome/say_hello" => "welcome#say_hello"
  get "index" => "messages"
  
  match ':controller(/:action(:/id(.format)))', via: :all
end
