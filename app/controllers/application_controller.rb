class ApplicationController < ActionController::Base

    # def admin
    #     # admin = false
    #     session[:is_admin] = false
    # end
    before_action :set_current_user

    def set_current_user
      User.current = current_user
    end


    def validUser
      begin 
        if (current_user == Product.find(params[:id]).user || current_user.isAdmin)  && !current_user.isBlocked    
          return true
        else      
          return false
        end
      rescue ActiveRecord::RecordNotFound => e
        puts e
      end
    end
end
