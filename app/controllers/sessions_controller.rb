class SessionsController < ApplicationController
  def new
  end

   def create
    user = User.authenticate(params[:email], params[:password])
    if user
      cookies[:auth_token] = user.auth_token
      Highrise::Base.site = user.site 
      Highrise::Base.user = user.token
      Highrise::Base.format = :xml

      redirect_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end
  

  def destroy
    cookies.delete(:auth_token)

    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
