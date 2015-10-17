Rails.application.routes.draw do
  root to: "top#index"
  post 'top/upload'
end
