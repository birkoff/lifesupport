class ApplicationController < ActionController::Base
  #protect_from_forgery
  before_filter :set_user
  #helper_method :authenticate

  #protected
  #def authenticate
  #  if session[:user_id].nil? then
  #    flash[:notice] = "Please Login"
  #    redirect_to root_path
  #  end
  #end

  protected
    def set_user
      @user = User.find(session[:id]) if @user.nil? && session[:id]
    end

    def authenticate
      return true if @user
      access_denied
      return false
    end

    def access_denied
      session[:return_to] = request.url
      flash[:error] = 'Oops. You need to login before you can view that page.' 
      redirect_to :controller => 'user', :action => 'login'
    end
end
