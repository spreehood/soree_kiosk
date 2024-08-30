Spree::Core::Engine.add_routes do
  namespace :api, defaults: { format: 'json' } do
    namespace :v2 do
      resources :displays, only: [:index, :show, :create, :update, :destroy] do
        resources :display_products, only: [:index, :create, :destroy]
      end
    end
  end 
end
