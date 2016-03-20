Rails.application.routes.draw do
  
  get 'admin/' => 'admin#index', as: :admin
  get 'admin/login' => 'admin#login', as: :login
  get 'admin/logout' => 'admin#logout', as: :logout

  get 'groups/all'

  resources :feedbacks
  resources :groups
  resources :group_members
  
  root             'publications#home'
  #resources :publication_reports
  get 'downloads' => 'active_devices#downloads'


  get 'users/:id/groups' => 'users#get_groups_for_user', as: :get_groups
  post 'users' => 'users#create'
  get 'users/:id/publications' => 'users#get_publications_for_user', as: :get_publications
  #post 'group_members' => 'group_members#create', as: :create_group_member 
  resources :active_devices

  resources :publications do
    resources :publication_reports
    resources :registered_user_for_publications
  end
  mount Resque::Server.new  => '/resque'


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