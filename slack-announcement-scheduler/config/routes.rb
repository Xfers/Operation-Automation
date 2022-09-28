Rails.application.routes.draw do
  get "welcome/say_hello" => "welcome#say_hello"
end
