class LoanController < ApplicationController
  #Se le indica al sistema que todas las funciones de este controlador usaran el layout navp por defecto
  layout "navp"
#Función encargada de añadir un elemento. Valida que se haya presionado el botó aceptar, obtiene los parametros de la vista Inventary
#valida que que los datos sean correctos
  def AddElement
    if params[:commit] == "Aceptar"
      if params[:id].blank? == false && params[:name].blank? == false && params[:description].blank? == false && params[:quantity].blank? == false
        if Element.find_by(id:params[:id]).nil?
          Element.create(id:params[:id],name:params[:name],quantity:params[:quantity],avaliable:params[:quantity],description:params[:description])
          redirect_to "/loan/Inventary", :flash =>{:alert => "El elemento se añadio satisfactoriamente"}
        else
          redirect_to "/loan/Inventary", :flash =>{:alert => "Ya tienes un elemento con este codigo"}
        end
        
      else
        if params[:id].blank?
          redirect_to "/loan/Inventary", :flash =>{:alert => "Debes ingresar un Codigo para el elemento"}
        elsif params[:name].blank?
          redirect_to "/loan/Inventary", :flash =>{:alert => "Debes darle un nombre al nuevo elemento"}
        elsif params[:quantity].blank?
          redirect_to "/loan/Inventary", :flash =>{:alert => "Debes seleccionar una cantidad de elementos"}
        elsif params[:description].blank? 
          redirect_to "/loan/Inventary", :flash =>{:alert => "Debes ingresar una descripcion valida"}
        end
      end
    else
      puts "aqui se elemina"
    end
  end
#Función encargada de añadir un prestamo. Obtiene los parametros de la vista createLoan
#valida que que los datos sean correctos y envia los datos a la base de datos. 
  def AddLoan
    if params[:student_id] == "0"
      if !Student.find_by(id:params[:idSt]).nil?
        if params[:fecha].blank? || params[:Hsolicitud].blank? || params[:element_id] == "0"
          if params[:element_id] == "0"
            redirect_to "/loan/createLoan", :flash =>{:alert => "Debes seleccionar un elemento a prestar"}
          elsif params[:fecha].blank?
            redirect_to "/loan/createLoan", :flash =>{:alert => "Debes una fecha para el prestamo"}
          elsif params[:Hsolicitud].blank?
            redirect_to "/loan/createLoan", :flash =>{:alert => "Debes una hora para el prestamo"}
          end
        else
          elementaux=Element.find(params[:element_id])
          if elementaux.quantity>=elementaux.avaliable && elementaux.avaliable>0
            active=0;
            Loan.where(student_id:params[:idSt]).each do |c| 
              if c.Hdevolucion.nil?
                active=1;
              end
            end
            if active == 0
              Loan.create(fecha:params[:fecha],Hsolicitud:params[:Hsolicitud],user_id:current_user.id,element_id:params[:element_id],student_id:params[:idSt])
              elementaux.update(avaliable:elementaux.avaliable-1)
              redirect_to "/login/loan"
            end
            if active == 1 
              redirect_to "/loan/createLoan", :flash =>{:alert => "Este estudiante ya tiene activo un prestamo"}
            end
          else
            redirect_to "/loan/createLoan", :flash =>{:alert => "No hay unidades de este elemento para prestar"}
          end
        end
      else
        if params[:idSt].blank? || params[:nameSt].blank? || params[:carrerSt].blank? ||params[:emailSt].blank?
          if params[:idSt].blank?
            redirect_to "/loan/createLoan", :flash =>{:alert => "Debes ingresar un codigo de estudiante para realizar un registro"}
          elsif params[:nameSt].blank?
            redirect_to "/loan/createLoan", :flash =>{:alert => "Debes ingresar un nombre de estudiante para realizar un registro"}
          elsif params[:carrerSt].blank?
            redirect_to "/loan/createLoan", :flash =>{:alert => "Debes ingresar una carrera para el estudiante"}
          elsif params[:emailSt].blank?
            redirect_to "/loan/createLoan", :flash =>{:alert => "Debes ingresar un correo electronico de estudiante para realizar un registro"}
          end
        else
          if params[:fecha].blank? || params[:Hsolicitud].blank? || params[:element_id] == "0"
            if params[:element_id] == "0"
              redirect_to "/loan/createLoan", :flash =>{:alert => "Debes seleccionar un elemento a prestar"}       
            elsif params[:fecha].blank?
              redirect_to "/loan/createLoan", :flash =>{:alert => "Debes una fecha para el prestamo"}
            elsif params[:Hsolicitud].blank?
              redirect_to "/loan/createLoan", :flash =>{:alert => "Debes una hora para el prestamo"}
            end
          else
            if params[:carrerSt] == "2"
              puts "2"
              Student.create(id:params[:idSt],name:params[:nameSt],carrer:"Ing.Sistemas y computacion",email:params[:emailSt])
            elsif params[:carrerStr] == "3"
              puts "3"
              Student.create(id:params[:idSt],name:params[:nameSt],carrer:"Ing.Electronica",email:params[:emailSt])
            elsif params[:carrerSt] == "4"
              puts "4"
              Student.create(id:params[:idSt],name:params[:nameSt],carrer:"Ing.Industrial",email:params[:emailSt])
            elsif params[:carrerSt] == "5"
              puts "5"
              Student.create(id:params[:idSt],name:params[:nameSt],carrer:"Ing.Minas",email:params[:emailSt])
            elsif params[:carrerSt] == "6"
              puts "6"
              Student.create(id:params[:idSt],name:params[:nameSt],carrer:"Ing.Geologica",email:params[:emailSt])
            elsif params[:carrerSt] == "7"
              puts "7"
              Student.create(id:params[:idSt],name:params[:nameSt],carrer:"Finanzas y comercio internacional",email:params[:emailSt])
            elsif params[:carrerSt] == "8"
              puts "8"
              Student.create(id:params[:idSt],name:params[:nameSt],carrer:"Administracion de empresas",email:params[:emailSt])
            elsif params[:carrerSt] == "9"  
              puts "8"
              Student.create(id:params[:idSt],name:params[:nameSt],carrer:"Contaduria publica",email:params[:emailSt])
            end
            elementaux=Element.find(params[:element_id])
            if elementaux.quantity>=elementaux.avaliable && elementaux.avaliable>0
              active=0;
              Loan.where(student_id:params[:idSt]).each do |c| 
                if c.Hdevolucion.nil?
                  active=1;
                end
              end
              if active == 0
                Loan.create(fecha:params[:fecha],Hsolicitud:params[:Hsolicitud],user_id:current_user.id,element_id:params[:element_id],student_id:params[:idSt])
                elementaux.update(avaliable:elementaux.avaliable-1)
                redirect_to "/login/loan"
              end
              if active == 1 
                redirect_to "/loan/createLoan", :flash =>{:alert => "Este estudiante ya tiene activo un prestamo"}
              end
            else
              redirect_to "/loan/createLoan", :flash =>{:alert => "No hay unidades de este elemento para prestar"}
            end
          end   
        end
      end
    else
      if !Student.find_by(id:params[:student_id]).nil?
        if params[:fecha].blank? || params[:Hsolicitud].blank? || params[:element_id] == "0"
          if params[:element_id] == "0"
            redirect_to "/loan/createLoan", :flash =>{:alert => "Debes seleccionar un elemento a prestar"}
          elsif params[:fecha].blank?
            redirect_to "/loan/createLoan", :flash =>{:alert => "Debes una fecha para el prestamo"}
          elsif params[:Hsolicitud].blank?
            redirect_to "/loan/createLoan", :flash =>{:alert => "Debes una hora para el prestamo"}
          end
        else
          elementaux=Element.find(params[:element_id])
          if elementaux.quantity>=elementaux.avaliable && elementaux.avaliable>0
            active=0;
            Loan.where(student_id:params[:student_id]).each do |c| 
              if c.Hdevolucion.nil?
                active=1;
              end
            end
            if active == 0
              Loan.create(fecha:params[:fecha],Hsolicitud:params[:Hsolicitud],user_id:current_user.id,element_id:params[:element_id],student_id:params[:student_id])
              elementaux.update(avaliable:elementaux.avaliable-1)
              redirect_to "/login/loan"
            end
            if active == 1 
              redirect_to "/loan/createLoan", :flash =>{:alert => "Este estudiante ya tiene activo un prestamo"}
            end
          else
            redirect_to "/loan/createLoan", :flash =>{:alert => "No hay unidades de este elemento para prestar"}
          end
        end
      end
    end
  end
#Función encargada de buscar un prestamo. Valida que se haya presionado el botó aceptar, obtiene los parametros de la vista searchLoan
#valida que que los datos sean correctos
  def serch
    if !Loan.find_by(student_id:params[:student_id],Hdevolucion:nil).nil?
      @opc=1;
      @estudiante=Student.where(id:params[:student_id]);
      @prestamo=Loan.find_by(student_id:params[:student_id],Hdevolucion:nil);
      puts params[:student_id]
    else
      @opc=2;
      Student.where(id:params[:student_id]).each do |c|
        @nombreE=c.name
      end
    end
  end
#Función encargada de eliminar un prestamo. Valida que se haya presionado el botó aceptar, obtiene los parametros de la vista deleteLoan
#valida que que los datos sean correctos
  def removeLoan
    if params[:loan_id] != "0"
      if params[:Hdevolucion].blank?
        redirect_to "/loan/deleteLoan", :flash =>{:alert => "Debes incluir una hora"}
      else
        prAct=Loan.find(params[:loan_id]);
        prAct.update(Hdevolucion:params[:Hdevolucion]);
        elementaux=Element.find(prAct.element_id);
        elementaux.update(avaliable:elementaux.avaliable+1)
        redirect_to "/login/loan"
      end
    else
      redirect_to "/loan/deleteLoan", :flash =>{:alert => "Debes seleccionar un prestamo"}
    end
  end
#Función encargada de eliminar un elemento. Valida que se haya presionado el botó aceptar, obtiene los parametros de la vista updateLoan
#valida que que los datos sean correctos
  def actualizeLoan
    if params[:loan_id] =="0" || params[:fecha].blank?  || params[:Hmodificada].blank? || params[:element_id] == "0"
      if params[:loan_id] == "0"
        redirect_to "/loan/updateLoan", :flash =>{:alert => "Debes identificar el prestamo a modificar"}
      elsif params[:element_id] == "0"
        redirect_to "/loan/updateLoan", :flash =>{:alert => "Debes seleccionar un elemento a prestar"}
      elsif params[:fecha].blank?
        redirect_to "/loan/updateLoan", :flash =>{:alert => "Debes seleccionar una fecha"}
      elsif params[:Hmodificada].blank?
        redirect_to "/loan/updateLoan", :flash =>{:alert => "Debes seleccionar una hora"}
      end
    else
      loanUpdate=Loan.find(params[:loan_id]);
      loanUpdate.update(fecha:params[:fecha], Hsolicitud:params[:Hmodificada], element_id:params[:element_id])
      redirect_to "/login/loan"
    end
  end
  
  def createLoan
    @InstructorActual=User.find(current_user.id).name+ " " +User.find(current_user.id).lastname;
    @PrNew= Loan.new
  end

  def searchLoan
    @InstructorActual=User.find(current_user.id).name+ " " +User.find(current_user.id).lastname;
  end

  def updateLoan
    @InstructorActual=User.find(current_user.id).name+ " " +User.find(current_user.id).lastname;
    @loansActive=Loan.where(Hdevolucion:nil);
  end

  def deleteLoan
    @InstructorActual=User.find(current_user.id).name+ " " +User.find(current_user.id).lastname;
    @loansActive=Loan.where(Hdevolucion:nil)
  end

  def Inventary
    @InstructorActual=User.find(current_user.id).name+ " " +User.find(current_user.id).lastname;
  end
end
