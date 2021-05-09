class GroupsController < ApplicationController
  layout "navg"
  
  def create
    idUsuario=current_user.id;
    if Group.find_by(id:params[:group][:id]).nil?
      if !params[:group][:id].blank? && !params[:group][:name].blank? && !params[:group][:description].blank? && !params[:group][:capacity].blank?
        Group.create(id:params[:group][:id], name:params[:group][:name], description:params[:group][:description], user_id:idUsuario,capacity:params[:group][:capacity],inscribed:0)
        redirect_to "/login/groups"
      else
        redirect_to "/groups/createGroups", :flash =>{:alert => "No puedes dejar campos en blanco"}
      end
    else
      redirect_to "/groups/createGroups", :flash =>{:alert => "El grupo ya existe"}
    end 
  end

  def show 
    if !Group.find(params[:group_name]).nil?
      @grupo=Group.find(params[:group_name]);
      @instructor=User.find([@grupo.user_id]);
      @registro=Record.where(group_id:params[:group_name]);
    else
      redirect_to "/groups/serchGroups", :flash =>{:alert => "No hay informacion disponible"}
    end
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
    if !params[:groupName].blank? || !params[:groupDescription].blank? || !params[:capacity].blank?
      @GrUpd=Group.find(params[:group_name]);
      if !params[:groupName].blank?
        @GrUpd.update(name:params[:groupName]);
      end
      if !params[:groupDescription].blank? 
        @GrUpd.update(description:params[:groupDescription]);
      end
      if !params[:capacity].blank?
        @GrUpd.update(capacity:params[:capacity]);
      end
      redirect_to "/groups/indexGroups"
    else
      redirect_to "/groups/updateGroups", :flash =>{:alert => "Debes modificar al menos un campo"}
    end
    
  end

  def Addparticipants   
    if params[:student_id] == "0"
      if !Student.find_by(id:params[:ParticipantCode]).nil?
        if params[:group_name] == "0" || params[:fecha].blank?
          if params[:group_name] == "0"
            redirect_to "/groups/participants", :flash =>{:alert => "Debes seleccionar un grupo para realizar el registro"}       
          elsif params[:fecha].blank?  
            redirect_to "/groups/participants", :flash =>{:alert => "Debes seleccionar una fecha para realizar el registro"}
          end
        else
          groupaux=Group.find(params[:group_name])
          if groupaux.inscribed<groupaux.capacity
            if Record.find_by(student_id:params[:ParticipantCode]).nil?
              Record.create(fecha:params[:fecha],group_id:params[:group_name],student_id:params[:ParticipantCode])
              groupaux.update(inscribed:groupaux.inscribed+1)
              redirect_to "/login/groups"
            else
              redirect_to "/groups/participants", :flash =>{:alert => "Este estudiante ya esta inscrito en el grupo"}
            end
          else
            redirect_to "/groups/participants", :flash =>{:alert => "No hay cupos diponibles en el grupo"}
          end
        end
      else
        if params[:ParticipantCode].blank? || params[:ParticipantName].blank? || params[:ParticipantCarrer] == "1" ||params[:ParticipantEmail].blank?
          if params[:ParticipantCode].blank?
            redirect_to "/groups/participants", :flash =>{:alert => "Debes ingresar un codigo de estudiante para realizar un registro"}
          elsif params[:ParticipantName].blank?
            redirect_to "/groups/participants", :flash =>{:alert => "Debes ingresar un nombre de estudiante para realizar un registro"}
          elsif params[:ParticipantCarrer] == "0"
            redirect_to "/groups/participants", :flash =>{:alert => "Debes ingresar una carrera para el estudiante"}
          elsif params[:ParticipantEmail].blank?
            redirect_to "/groups/participants", :flash =>{:alert => "Debes ingresar un correo electronico de estudiante para realizar un registro"}
          end
        else
          if params[:fecha].blank? || params[:group_name]== "0"
            if params[:fecha].blank?
              redirect_to "/groups/participants", :flash =>{:alert => "Debes una fecha para el prestamo"}
            elsif params[:group_name]== "0"
              redirect_to "/groups/participants", :flash =>{:alert => "Debes seleccionar un grupo para realizar el registro"}
            end
          else
            if params[:ParticipantCarrer] == "2"
              puts "2"
              Student.create(id:params[:ParticipantCode],name:params[:ParticipantName],carrer:"Ing.Sistemas y computacion",email:params[:ParticipantEmail])
            elsif params[:ParticipantCarrer] == "3"
              puts "3"
              Student.create(id:params[:ParticipantCode],name:params[:ParticipantName],carrer:"Ing.Electronica",email:params[:ParticipantEmail])
            elsif params[:ParticipantCarrer] == "4"
              puts "4"
              Student.create(id:params[:ParticipantCode],name:params[:ParticipantName],carrer:"Ing.Industrial",email:params[:ParticipantEmail])
            elsif params[:ParticipantCarrer] == "5"
              puts "5"
              Student.create(id:params[:ParticipantCode],name:params[:ParticipantName],carrer:"Ing.Minas",email:params[:ParticipantEmail])
            elsif params[:ParticipantCarrer] == "6"
              puts "6"
              Student.create(id:params[:ParticipantCode],name:params[:ParticipantName],carrer:"Ing.Geologica",email:params[:ParticipantEmail])
            elsif params[:ParticipantCarrer] == "7"
              puts "7"
              Student.create(id:params[:ParticipantCode],name:params[:ParticipantName],carrer:"Finanzas y comercio internacional",email:params[:ParticipantEmail])
            elsif params[:ParticipantCarrer] == "8"
              puts "8"
              Student.create(id:params[:ParticipantCode],name:params[:ParticipantName],carrer:"Administracion de empresas",email:params[:ParticipantEmail])
            elsif params[:ParticipantCarrer] == "9"  
              puts "8"
              Student.create(id:params[:ParticipantCode],name:params[:ParticipantName],carrer:"Contaduria publica",email:params[:ParticipantEmail])
            end
            groupaux=Group.find(params[:group_name])
            if groupaux.inscribed<groupaux.capacity
              if Record.find_by(student_id:params[:ParticipantCode]).nil?
                Record.create(fecha:params[:fecha],group_id:params[:group_name],student_id:params[:ParticipantCode])
                groupaux.update(inscribed:groupaux.inscribed+1)
                redirect_to "/login/groups"
              else
                redirect_to "/groups/participants", :flash =>{:alert => "Este estudiante ya esta inscrito en el grupo"}
              end
            else
              redirect_to "/groups/participants", :flash =>{:alert => "No hay cupos diponibles en el grupo"}
            end

          end 
        end
      end
    else
      if !Student.find_by(id:params[:student_id]).nil?
        if params[:fecha].blank? || params[:group_name]== "0"
          if params[:fecha].blank?
            redirect_to "/groups/participants", :flash =>{:alert => "Debes una fecha para el prestamo"}
          elsif params[:group_name]== "0"
            redirect_to "/groups/participants", :flash =>{:alert => "Debes seleccionar un grupo para realizar el registro"}
          end
        else
          groupaux=Group.find(params[:group_name])
          if groupaux.inscribed<groupaux.capacity
            if Record.find_by(student_id:params[:student_id]).nil?
              Record.create(fecha:params[:fecha],group_id:params[:group_name],student_id:params[:student_id])
              groupaux.update(inscribed:groupaux.inscribed+1)
              redirect_to "/login/groups"
            else
              redirect_to "/groups/participants", :flash =>{:alert => "Este estudiante ya esta inscrito en el grupo"}
            end
          else
            redirect_to "/groups/participants", :flash =>{:alert => "No hay cupos diponibles en el grupo"}
          end
        end
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
