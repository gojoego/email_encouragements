# config/routes.rb
Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/mail", as: "dev_mail"
  end

  root "root#index"
  post "/", to: "root#create"
end

