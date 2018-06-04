Rails.application.routes.draw do
  resources :posts do
    collection do
      post :search, to: 'posts#index'
      get :search, to: 'posts#index'
    end
  end
  devise_for :users
  root 'pages#home'

  get  '/users/account', to: 'users#index'
  get  '/users/account/:id/edit', to: 'users#edit', as: 'edit_user'
  get  '/users/:id/toggle_get_notifactions' => 'users#toggle_get_notifactions', as: 'toggle_get_notifactions'

  get  '/approve_posts', to: 'posts#approve_posts'
  get  '/posts/approve_posts', to: 'posts#approve_posts'
  post '/posts/approve_posts', to: 'posts#approve_posts'
  get  '/posts/:id/approve', to: 'posts#approve', as: 'approve'

  post 'posts/:id/toggle_save' => 'posts#toggle_save', as: 'toggle_save'

  get 'pages/about' => "pages#about", as: 'about'
end
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
