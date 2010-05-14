ActionController::Routing::Routes.draw do |map|
  map.resources :card_sounds

  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"

  map.resources :user_sessions

  map.resources :users

  map.resources :decks

  map.connect 'quiz/quiz_card', :controller => 'quiz', :action => 'quiz_card'

  map.connect 'quiz/:id', :controller => 'quiz', :action => 'quiz'

  map.connect 'multiple_choice/game', :controller => 'quiz', :action => 'multiple_choice_game'
  map.connect 'multiple_choice/:id', :controller => 'quiz', :action => 'multiple_choice'

  map.connect 'about', :controller => 'meta_pages', :action => 'action'
#  map.connect 'news', :controller => 'meta_pages', :action => 'news' # not yet implemented

  map.root :controller => 'quiz', :action => 'index'

  map.connect 'games/:action', :controller => 'quiz'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
