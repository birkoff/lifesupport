class UsersController < ApplicationController
  def login
    @user = User.new
  end
  
  def process_login
    if user = User.authenticate(params[:username], params[:password])
        session[:id] = user.id # Remember the user's id during this session 
        redirect_to session[:return_to] || root_url
    else
        flash[:error] = 'Invalid login.' 
        redirect_to :action => 'login'
      end
  end
  
  def logout
    reset_session
    session[:id] = nil
    flash[:notice] = "Logged out!"
    redirect_to :action => 'login' 
  end
end
