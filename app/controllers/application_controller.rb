class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :update_session
  before_filter :pageroot
  before_filter :set_current_user

  layout :layout_by_resource



  def pageroot
    @pageroots = Page.roots.asc(:order)
  end
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
   redirect_to root_url
  end
    private
  def after_sign_out_path_for(resource_or_scope)
    home_index_path
  end
  def after_sign_in_path_for(resource_or_scope)
    backoffice_application_index_path
  end
  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end
  def set_current_user
    User.current_user= User.where(:_id => session[:user_id])
  end

  protected
  #set session
  def update_session
    if user_signed_in?
    session[:user_id] = current_user._id

    end
  end
  def ckeditor_filebrowser_scope(options = {})
    super({ :assetable_id => current_user.id, :assetable_type => 'User' }.merge(options))
  end
end
