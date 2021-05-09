Rails.application.routes.draw do
  
  get 'loan/createLoan'
  get 'loan/searchLoan'
  get 'loan/updateLoan'
  get 'loan/deleteLoan'
  get 'loan/Inventary'
  get 'loan/serchLoan'
  post 'loan/AddElement'
  post 'loan/AddLoan'
  post 'loan/serch'
  post 'loan/removeLoan'
  post 'loan/actualizeLoan'
  resources :loans

  get 'groups/indexGroups'
  get 'groups/createGroups'
  get 'groups/searchGroups'
  get 'groups/updateGroups'
  get 'groups/deleteGroups'
  get 'groups/participants'
  post 'groups/show'
  post 'groups/Addparticipants'
  resources :groups
  #devise_for :users
  devise_for :users, :controllers =>{sessions:'users/sessions', registrations:'users/registrations'}
  root 'login#login'
  
  


  get 'login/loan'
  get 'login/groups'

  #get 'users/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
