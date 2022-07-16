Rails.application.routes.draw do
  root to: ->(env) { [204, {}, ['welcome']] }
  resources :users do
    get :lock, on: :collection
    get :other, on: :collection
  end
end
