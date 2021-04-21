class LoginController < ApplicationController

  
  #layout "navg", only:[:groups]
  #layout "navp", only:[:loan]
  
  def login
  end

  def loan
  	render layout: "navp";
  end

  def groups
  	@InstructorActual=User.find(current_user.id).name+ " " +User.find(current_user.id).lastname;
  	render layout: "navg";
  end
  
end
