SnuggleCloud::Application.routes.draw do
	resources :users
	resources :couples
	resource :session

	root :to => "static#main"
	match '/about' => "static#about", :as => "about"
	match '/login' => "sessions#new", :as => "login"
	match '/logout' => "sessions#destroy", :as => "logout"

end
