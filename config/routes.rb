Rails.application.routes.draw do
  root to: "button#index"

  scope module: 'api' do
    scope 'api' do
      resources :products
    end
  end

  get 'products', to: 'button#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
