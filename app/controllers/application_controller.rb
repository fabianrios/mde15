class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def realtime_user_id
    return 42 # if using devise, change this to current_user.id
  end

  def realtime_server_url
    # point this to your node.js-socket.io-redis/zmq realtime server (you can set this later)
    return 'http://res.herokuapp.com'
  end
  
  def configure_permitted_parameters
      devise_parameter_sanitizer.for(:account_update) do |u|
            u.permit(:email, :password, :password_confirmation, :current_password, :nombre, :lugar, :direccion, :telefono, :comuna, :barrio, :categoria, :logo, :web, :imagen, :descripcion, :user_id, :admin)
      end
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :nombre, :lugar, :direccion, :telefono, :comuna, :barrio, :categoria, :logo, :web, :imagen, :descripcion, :user_id, :admin)}
  end
  
  rescue_from ActiveRecord::RecordNotFound do
    respond_to do |type|
      type.all  { render :nothing => true, :status => 404 }
    end
  end
end
