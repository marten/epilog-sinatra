class IsUserSite
  def self.matches?(request)
    request.subdomain != "admin"
  end
end

class NotUserSite
  def self.matches?(request)
    not IsUserSite.matches?(request)
  end
end


Epilog::Application.routes.draw do
  # Administration and management area
  constraints(NotUserSite) do
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
  constraints(IsUserSite) do
    match '*path' => 'sites/pages#show'
    root :to => 'sites/pages#show'
  end
end
