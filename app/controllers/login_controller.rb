class LoginController < ApplicationController
  #layout "navg", only:[:groups]
  #layout "navp", only:[:loan]
  
  def login
  end

  def loan
  	render layout: "navp";
  end

  def groups
  	render layout: "navg";
  end
  
end
