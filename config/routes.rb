ReEducation::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  match 'contact' => 'contact#new', :as => 'contact', :via => :get
  match 'contact' => 'contact#create', :as => 'contact', :via => :post
  match 'contact/thanks' => 'contact#thanks', :as => 'contact', :via => :post

  match 'login' => 'sessions#new', :as => 'login', :via => :get
  match 'logout' => 'sessions#destroy', :as => 'logout', :via => :get

  resources :sessions, only: [:new, :create]

  # The priority is based upon order of creation:
  # first created -> highest priority.
  match 'jsonp' => 'application#jsonp', :as => 'jsonp', :via => :get
  match 'cors' => 'application#cors', :as => 'cors', :via => :get
  match 'cross_post' => 'application#cross_post', :as => 'cross_post', :via => :post
  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  resources :lessonplans do
    resources :tasks
    resources :comments
    resources :lessonplan_attachments, :as => 'attachments', :path => 'attachments'
  end

  resources :publishers
  resources :users

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
  root :to => 'lessonplans#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

  # ActionController::Routing::Routes.draw do |map|
  #   map.simple_captcha '/simple_captcha/:action', :controller => 'simple_captcha'
  # end
end
