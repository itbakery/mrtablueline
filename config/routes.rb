require 'sidekiq/web'
Mrtablueline::Application.routes.draw do


  resources :sections

  #get "progresses/index"
  match "/progresses"  => "progresses#index"
  match "/progresses/station/:id" => "progresses#show"
  match "/progresses/report/:id" => "progresses#report"
  match "/progresses/announce/:id" => "progresses#announce"
  match "/progresses/effect/:id" => "progresses#effect"
  match "/progresses/effect/" => "progresses#effect"
  match "/progresses/effect_latest/" => "progresses#effect_latest"
  match "/progresses/effect_monthly/" => "progresses#effect_monthly"
  match "/progresses/report_latest/" => "progresses#report_latest"
  match "/progresses/report_monthly/" => "progresses#report_monthly"
  match "/progresses/activity/" => "progresses#activity"
  match "/progresses/activity_latest/" => "progresses#activity_latest"
  match "/progresses/activity_monthly/" => "progresses#activity_monthly"
  #get "progresses/fullmap"
  match "/fullmap" => "progresses#fullmap"

  #resources :stations

  resources :announces, :only => [:show]

  #resources :effects

  #resources :mediatypes
  resources :activities , :only => [:show]
  #resources :companies
  #resources :profiles
  #resources :images
  #resources :reports
  resources :geopoints
  resources :pages

  namespace :admin do resources :geonodes end

  mount Ckeditor::Engine => '/ckeditor'

  get "home/index"
  get "home/underconstruction"
  get "welcome/index"
  root to: "home#index"
  mount Sidekiq::Web, at: 'sidekiq'


  match "/mrtamap" => "home#mrtamap"
  devise_for :users
  namespace :admin do
    resources :users do
      member do
        get 'assign_supervisor_role'
        get 'remove_supervisor_role'
        get 'assign_mrtaadmin_role'
        get 'remove_mrtaadmin_role'
        get 'assign_author_role'
        get 'remove_author_role'
      end
    end

  end
  namespace :backoffice do
    resources :application, :only => [:index]
    resources :pages
    resources :reports do
      get 'approve', :on => :member
    end

    resources :stations
    resources :profiles
    resources :companies
    resources :activities do
      get 'approve', :on => :member
    end

    resources :mediatypes
    resources :effects
    resources :sections
    resources :announces do
      get 'approve', :on => :member
    end
  end
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
