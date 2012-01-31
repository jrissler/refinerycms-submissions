::Refinery::Application.routes.draw do
  resources :submissions, :only => [:index, :show]

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :submissions, :except => :show do
      collection do
        post :update_positions
      end
    end
  end
end
