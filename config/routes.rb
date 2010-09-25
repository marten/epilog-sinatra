require 'route_constraints'

Epilog::Application.routes.draw do
  # Administration and management area
  constraints(RouteConstraints::SiteArea::IsNotSite) do
    devise_for :admins
    devise_for :users

    namespace :admin do
      resources :sites do
        member do
          get :authorize
        end
      end
    end
    
    root :to => 'admin/sites#index'
  end

  # Sites
  constraints(RouteConstraints::SiteArea::IsSite) do
    constraints(RouteConstraints::SiteArea::PageRequest) do
      # Blogs
      match 'blog/:year/:month/:day/:slug' => 'sites/posts#show'
      match 'blog(/:year(/:month(/:day)))' => 'sites/posts#index'

      # # Photos
      # match 'photos/:year/:month/:day/:slug' => 'sites/posts#show'
      # match 'photos(/:year(/:month(/:day)))' => 'sites/posts#index'
      # 
      # # Albums
      # match 'albums/:year/:month/:day/:slug' => 'sites/posts#show'
      # match 'albums(/:year(/:month(/:day)))' => 'sites/posts#index'
      
      # All other pages
      match '*path' => 'sites/pages#show'
    end
    
    match '*path' => 'sites/files#show'
    root :to => 'sites/pages#show'
  end
end
