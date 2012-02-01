Refinery::Application.routes.draw do
  get '/contact', :to => 'submissions#new', :as => 'new_submission'
  resources :contact,
            :only => :create,
            :as => :submissions,
            :controller => 'submissions' do
    collection do
      get :thank_you
    end
  end

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :submissions, :only => [:index, :show, :destroy] do
      collection do
        get :spam
      end
      member do
        get :toggle_spam
      end
    end
    resources :submission_settings, :only => [:edit, :update]
  end
end
