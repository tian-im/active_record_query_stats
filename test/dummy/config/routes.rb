Rails.application.routes.draw do
  root to: ->(env) { [204, {}, ['welcome']] }
  resources :users do
    collection do
      get :set_transaction
      get :rollback
      get :lock
      get :other
    end
  end
end
