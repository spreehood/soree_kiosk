Spree::Core::Engine.add_routes do
  namespace :api, defaults: { format: 'json' } do
    namespace :v2 do
      resources :vendors, only: [] do
        resources :displays, only: [:index, :show, :create, :update, :destroy]
      end

      resources :displays, only: [] do
        resources :display_products, only: [:index, :create, :destroy]
        resources :products, only: [:index]
      end
    end
  end
end
