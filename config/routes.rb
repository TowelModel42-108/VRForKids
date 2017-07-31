Rails.application.routes.draw do
  devise_for :users

  # get 'dash/enter'
  # get 'games/play/:id'
  get 'dash/dashboard'

  root 'static#welcome'
  get 'static/welcome'
  get 'game/index'

  get 'react_game/game'
  get 'soundsgame' => 'react_game#show', id: 1, as: 'soundsgame'
  # get 'game/:id/soundsgame' => 'react_game#show', id: 1, as: 'soundsgame'  #current user id need to be fixed
  get 'game_session/stats' => 'game_session#statistics', as: 'stats'



  get 'game/:id/show', to: 'game#show', as:'game_show'

  get 'dashboard/game_sessions/', to: 'game_session#index', as: 'sessions_index'

  get 'game/:id/play', to: 'game_session#start', as: 'session_start'
  post 'game/:id/play', to: 'game_session#store', as:'session_store'

  get '/game/:id/user/:user_id/update_score', to: 'game_session#update_score'
  get '/game/:id/user/:user_id/get_score', to: 'game_session#get_score'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
