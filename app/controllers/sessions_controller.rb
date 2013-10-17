class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      flash[:notice] = "Logged in"
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:notice] = "Could not log in"
      render :new
    end
  end

  def destroy
    flash[:notice] = "Logged out"
    session[:user_id] = nil
    redirect_to root_path
  end
end
