Rails.application.routes.draw do
  #devise_for :users
  devise_for :users, :controllers =>{sessions:'users/sessions', registrations:'users/registrations'}
  root 'login#login'




  get 'login/ah'
  get 'login/oh'
  #get 'users/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
