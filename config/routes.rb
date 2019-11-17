Rails.application.routes.draw do
  get 'new', to: 'games#new'
  post 'result', to: 'games#result'
  get 'result', to: 'games#result'
end
