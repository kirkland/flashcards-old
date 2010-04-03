ActionController::Routing::Routes.draw do |map|
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"

  map.resources :user_sessions

  map.resources :users do |user|
    user.resources :decks
  end

  map.resources :decks

  map.resources :cards

  map.connect 'decks', :controller => 'decks', :action => 'all_decks'

  map.connect 'quiz/quiz_card', :controller => 'quiz', :action => 'quiz_card'

  map.connect 'quiz/:id', :controller => 'quiz', :action => 'quiz'

  map.root :controller => 'quiz', :action => 'index'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
