class GroupsController < ApplicationController
  
  layout "navg"

  def create
    idUsuario=current_user.id;
    if Group.find_by(id:params[:group][:id]).nil?
      if !params[:group][:id].blank? && !params[:group][:name].blank? && !params[:group][:description].blank?
        Group.create(id:params[:group][:id], name:params[:group][:name], description:params[:group][:description], user_id:idUsuario)
        redirect_to "/login/groups"
      else
        puts "No puedes dejar campos en blanco"
      end
    else
      puts "El grupo ya existe"
    end 
  end
  def show 

    puts Group.find_by(user_id:current_user.id)
  end
  def destroy
    if !Group.find_by(id:params[:group_name]).nil?
      @gr=Group.find(params[:group_name])
      @gr.destroy
      redirect_to "/groups/indexGroups"
    else
      puts "No es posible realizar la eliminacion"
    end
  end

  def update 
    if !params[:groupName].blank? || !params[:groupDescription].blank?
      @GrUpd=Group.find(params[:group_name]);
      if !params[:groupName].blank? && !params[:groupDescription].blank?
        @GrUpd.update(name:params[:groupName],description:params[:groupDescription]);
        puts "Se actualizaron los campos de nombre y descripcion"
      elsif !params[:groupName].blank? && params[:groupDescription].blank? 
        @GrUpd.update(name:params[:groupName]);
        puts "Se actualizo el campo de nombre"
      elsif params[:groupName].blank? && !params[:groupDescription].blank?
        @GrUpd.update(description:params[:groupDescription]);
        puts "Se actualizo el campo de descripcion"
      end
      redirect_to "/groups/indexGroups"
    else
      puts "Verifica los campos"
    end
    
  end

  def Addparticipants
    if params[:group_name].blank? == false && params[:ParticipantCode].blank? == false && params[:ParticipantName].blank? == false && params[:ParticipantEmail].blank? == false && params[:ParticipantCarrer] != "1"
      puts "añadir "
    else
      if params[:group_name].blank?
        puts "Debes ingresar seleccionar un grupo"
      elsif params[:ParticipantCode].blank?
        puts "Ingresa un codigo valido para el participante"
      elsif params[:ParticipantName].blank?
        puts "Ingresa un nombre para el participante"
      elsif params[:ParticipantEmail].blank? 
        puts "Ingresa un correo valido para el participante"
      elsif params[:ParticipantCarrer] == "1"
        puts "Debes seleccionar una carrera"
      end
    end
  end





  def indexGroups
    @InstructorActual=User.find(current_user.id).name+ " " +User.find(current_user.id).lastname;
  end

  def createGroups
    @GrNew=Group.new;
    @InstructorActual=User.find(current_user.id).name+ " " +User.find(current_user.id).lastname;
  end

  def searchGroups
    @InstructorActual=User.find(current_user.id).name+ " " +User.find(current_user.id).lastname;
    @ActGr= Group.new;
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
