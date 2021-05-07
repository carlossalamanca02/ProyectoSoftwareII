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
      redirect_to "/groups/createGroups", :flash =>{:alert => "El grupo ya existe"}
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
      redirect_to "/groups/createGroups", :flash =>{:alert => "No fue posible eliminar el grupo"}
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
      redirect_to "/groups/createGroups", :flash =>{:alert => "Revise los datos ingresados"}
    end
    
  end

  def Addparticipants
    if params[:group_name].blank? == false && params[:ParticipantCode].blank? == false && params[:ParticipantName].blank? == false && params[:ParticipantEmail].blank? == false && params[:ParticipantCarrer] != "1"
      puts "añadir "
    else
      if params[:group_name].blank?
        redirect_to "/groups/createGroups", :flash =>{:alert => "Debes ingresar seleccionar un grupo"}
      elsif params[:ParticipantCode].blank?
        redirect_to "/groups/createGroups", :flash =>{:alert => "Ingresa un codigo valido para el participante"}
        puts "Ingresa un codigo valido para el participante"
      elsif params[:ParticipantName].blank?
        redirect_to "/groups/createGroups", :flash =>{:alert => "Ingresa un nombre para el participante"}
        puts "Ingresa un nombre para el participante"
      elsif params[:ParticipantEmail].blank? 
        redirect_to "/groups/createGroups", :flash =>{:alert => "Ingresa un correo valido para el participante"}
        puts "Ingresa un correo valido para el participante"
      elsif params[:ParticipantCarrer] == "1"
        redirect_to "/groups/createGroups", :flash =>{:alert => "Debes seleccionar una carrera"}
        puts "Debes seleccionar una carrera"
      end
    end
  end





  def indexGroups
  end

  def createGroups
    @GrNew=Group.new;
  end

  def searchGroups
    @ActGr= Group.new;
  end

  def updateGroups
  end

  def deleteGroups
        render layout: "navg";
  end

  def participants
  end

 
end
