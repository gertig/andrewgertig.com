Andrewgertig::Application.routes.draw do

  resources :galleries do
    resources :pictures do
      collection do
        post 'make_default'
      end
    end
  end
  resources :pictures

  resources :users do
    resources :posts
    resources :pages
  end

  resources :posts
  resources :pages

  devise_for :users, :skip => [:sessions] #, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  # https://github.com/plataformatec/devise/wiki/How-To:-Change-the-default-sign_in-and-sign_out-routes#steps-for-rails-300-forward
  as :user do
    get     "login"   => "devise/sessions#new",     :as => :new_user_session    # new_user_session_path
    post    "login"   => "devise/sessions#create",  :as => :user_session  # user_session_path
    # delete  "logout"  => "devise/sessions#destroy", :as => :destroy_user_session # destroy_user_session_path
    get  "logout"  => "devise/sessions#destroy", :as => :destroy_user_session # destroy_user_session_path
  end

  # devise_scope :user do
  #   get "/login" => "devise/sessions#new"
  # end

  # get '/users/sign_in' => "devise/sessions#new"

  # Devise security
  authenticate :user do
    # mount Sidekiq::Web => '/sidekiq'
  end

  match '/feed/rss' => 'posts#feed',
        :as => :feed,
        :defaults => { :format => 'atom' },
        :via => :get

  # Omniauth
  get '/auth/:provider' => 'sessions#passthru'
  get '/auth/:provider/callback', :to => 'sessions#create'
  get '/auth/failure', :to => 'sessions#failure'


  get "/:year(/:month)/:id" => "posts#show", :constraints => { :year => /\d{4}/, :month => /\d{2}/ }, :via => :get

  # Pages
  get "/about", to: redirect('/pages/about')
  get "hire-me" => "home#hire_me", :as => :hire_me
  get "dashboard" => "dashboard#show", :as => :dashboard
  get "archives" => "posts#index", :as => :archives

  # Catch all for posts should be after custom page routes
  get '/:id' => "posts#show"

  # ROOT
  root :to => 'home#index'
  # get "home/index"

  get "/tag/:a_tag" => "home#index" # This catches links that used to point to the word press tag pages for things like /tag/seo and /tag/review and routes them to the home page

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
end
