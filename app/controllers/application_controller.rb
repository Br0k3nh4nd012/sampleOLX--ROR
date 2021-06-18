class ApplicationController < ActionController::Base

    # def admin
    #     # admin = false
    #     session[:is_admin] = false
    # end
    before_action :set_current_user

    def set_current_user
      User.current = current_user
    end
end
