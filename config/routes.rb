DbRuby::Application.routes.draw do

  get 'signup_user', to: 'users#new', as: 'signup_user'
  get 'signup_employee', to: 'employees#new', as: 'signup_employee'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'incident_close/:id', to: 'incidents#close', as: 'incident_close'
  get 'incident_assign/:id', to: 'incidents#assign', as: 'incident_assign'
  get 'incident_update/:id', to: 'incidents#update', as: 'incident_update'
  get 'index_employee', to: 'attempts#index_employee', as: 'index_employee'
  get 'create_attempt/:id', to: 'attempts#create', as: 'create_attempt'

  root to: "static_pages#home"
  resources :incidents do
    resources :attempts
  end
  resources :sessions
  resources :users
  resources :employees

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
