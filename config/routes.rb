Rails.application.routes.draw do
  
  get 'groups/indexGroups'
  get 'groups/createGroups'
  get 'groups/searchGroups'
  get 'groups/updateGroups'
  get 'groups/deleteGroups'
  get 'groups/participants'
  post 'groups/show'
  post 'groups/Addparticipants'
  
  #devise_for :users
  devise_for :users, :controllers =>{sessions:'users/sessions', registrations:'users/registrations'}
  root 'login#login'
  
  resources :groups


  get 'login/loan'
  get 'login/groups'

  #get 'users/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
