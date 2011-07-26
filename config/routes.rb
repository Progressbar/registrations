::Refinery::Application.routes.draw do

  resources :registrations

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :registrations, :only => [:index, :show, :destroy, :accept, :reject] do
      collection do
        get :spam
        get :approved
        get :rejected
      end
      member do
        get :toggle_spam
        get :approved
        get :rejected
      end      
    end
  end
end