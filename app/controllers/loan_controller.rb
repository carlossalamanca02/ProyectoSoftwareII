class LoanController < ApplicationController
  layout "navp"
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

  def AddLoan
    if params[:student_id] == "0"
      if !Student.find_by(id:params[:idSt]).nil?
        if params[:fecha].blank? || params[:Hsolicitud].blank? || params[:element_id].blank?
          if params[:fecha].blank?
            redirect_to "/loan/createLoan", :flash =>{:alert => "Debes una fecha para el prestamo"}
          elsif params[:Hsolicitud].blank?
            redirect_to "/loan/createLoan", :flash =>{:alert => "Debes una hora para el prestamo"}
          elsif params[:element_id].blank?
            redirect_to "/loan/createLoan", :flash =>{:alert => "Debes seleccionar un elemento a prestar"}
          end
        else
          Loan.create(fecha:params[:fecha],Hsolicitud:params[:Hsolicitud],user_id:current_user.id,element_id:params[:element_id],student_id:params[:idSt])
          #redirect_to "/loan/createLoan", :flash =>{:alert => "Prestamo creado exitosamente"}
          redirect_to "/login/loan"
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
          if params[:fecha].blank? || params[:Hsolicitud].blank? || params[:element_id].blank?
            if params[:fecha].blank?
              redirect_to "/loan/createLoan", :flash =>{:alert => "Debes una fecha para el prestamo"}
            elsif params[:Hsolicitud].blank?
              redirect_to "/loan/createLoan", :flash =>{:alert => "Debes una hora para el prestamo"}
            elsif params[:element_id].blank?
              redirect_to "/loan/createLoan", :flash =>{:alert => "Debes seleccionar un elemento a prestar"}
            end
          else
            Student.create(id:params[:idSt],name:params[:nameSt],carrer:params[:carrerSt],email:params[:emailSt])
            Loan.create(fecha:params[:fecha],Hsolicitud:params[:Hsolicitud],user_id:current_user.id,element_id:params[:element_id],student_id:params[:idSt])
            #redirect_to "/loan/createLoan", :flash =>{:alert => "Prestamo creado exitosamente"}
            redirect_to "/login/loan"
          end
           
        end
        
      end
    else
      if !Student.find_by(id:params[:student_id]).nil?
        if params[:fecha].blank? || params[:Hsolicitud].blank? || params[:element_id].blank?
          if params[:fecha].blank?
            redirect_to "/loan/createLoan", :flash =>{:alert => "Debes una fecha para el prestamo"}
          elsif params[:Hsolicitud].blank?
            redirect_to "/loan/createLoan", :flash =>{:alert => "Debes una hora para el prestamo"}
          elsif params[:element_id].blank?
            redirect_to "/loan/createLoan", :flash =>{:alert => "Debes seleccionar un elemento a prestar"}
          end
        else
          Loan.create(fecha:params[:fecha],Hsolicitud:params[:Hsolicitud],user_id:current_user.id,element_id:params[:element_id],student_id:params[:student_id])
          #redirect_to "/loan/createLoan", :flash =>{:alert => "Prestamo creado exitosamente"}
          redirect_to "/login/loan"
        end
      end
    end
  end
  



  def serch
    puts params[:student_id]
  end
  
  
  def removeLoan
    if params[:loan_id] != "0"
      if params[:Hdevolucion].blank?
        redirect_to "/loan/deleteLoan", :flash =>{:alert => "Debes incluir una hora"}
      else
        prAct=Loan.find(params[:loan_id]);
        prAct.update(Hdevolucion:params[:Hdevolucion])
        redirect_to "/login/loan"
      end
    else
      redirect_to "/loan/deleteLoan", :flash =>{:alert => "Debes seleccionar un prestamo"}
    end
    
  end






 
  def actualizeLoan
  
  
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
  end

  def deleteLoan
    @InstructorActual=User.find(current_user.id).name+ " " +User.find(current_user.id).lastname;
    @loansActive=Loan.where(Hdevolucion:nil)
  end

  def Inventary
    @InstructorActual=User.find(current_user.id).name+ " " +User.find(current_user.id).lastname;
  end
end
