class GroupsController < ApplicationController
  
  layout "navg"

  def indexGroups
    @InstructorActual=User.find(current_user.id).name+ " " +User.find(current_user.id).lastname;
  end

  def createGroups

    @InstructorActual=User.find(current_user.id).name+ " " +User.find(current_user.id).lastname;

  end

  def searchGroups
    @InstructorActual=User.find(current_user.id).name+ " " +User.find(current_user.id).lastname;

  end

  def updateGroups
    @InstructorActual=User.find(current_user.id).name+ " " +User.find(current_user.id).lastname;

  end

  def deleteGroups
    
    @InstructorActual=User.find(current_user.id).name+ " " +User.find(current_user.id).lastname;
    render layout: "navg";
  end

  def participants
    @InstructorActual=User.find(current_user.id).name+ " " +User.find(current_user.id).lastname;

  end
end
