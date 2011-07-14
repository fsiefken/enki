Enki::Application.routes.draw do
  namespace 'admin' do
    resource :session

    resources :posts, :pages do
      post 'preview', :on => :collection
    end
    resources :comments
    resources :undo_items do
      post 'undo', :on => :member
    end

    match 'health(/:action)' => 'health', :action => 'index', :as => :health

    root :to => 'dashboard#show'
  end

  match '+' => redirect('https://plus.google.com/108578129508819676730/posts')
  match '2010/11/12/rvm-virtualenv' => redirect('/2010/11/13/rvm-virtualenv')
  match "/stories/:name" => redirect {|params| "/posts/#{params[:name].pluralize}" }
  match "/stories" => redirect {|p, req| "/posts/#{req.subdomain}" }


  resources :archives, :only => [:index]
  resources :pages, :only => [:show]

  constraints :year => /\d{4}/, :month => /\d{2}/, :day => /\d{2}/ do
    post ':year/:month/:day/:slug/comments' => 'comments#index'
    get ':year/:month/:day/:slug/comments/new' => 'comments#new'
    get ':year/:month/:day/:slug' => 'posts#show'
  end

  scope :to => 'posts#index' do
    get 'posts.:format', :as => :formatted_posts
    get '(:tag)', :as => :posts
  end


  root :to => 'posts#index'
end
