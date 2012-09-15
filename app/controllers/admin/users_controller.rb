class Admin::UsersController < ApplicationController
  layout 'backoffice'
  before_filter :authenticate_user!

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
    respond_to do |format|
      format.html
    end
  end
  def new
    @user = User.new
    @profile = @user.build_profile
    respond_to do |format|
      format.html # new.html.erb
      #format.json { render json: @admin_user }
    end
  end
  #show user
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
    end
  end
  #create user
  def create
    @user = User.new(params[:user])
    @user.confirmed_at = DateTime.now
    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_path, notice: 'User was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def edit
    @user = User.find(params[:id])
    @user.profile ||= @user.build_profile
  end


  #update
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to admin_users_path, notice: 'User was successfully updated.' }
      else
        format.html { render action: "edit" , notice: 'Update user error'}
      end
    end
  end
  # DELETE /admin/pages/1
  # DELETE /admin/pages/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to admin_users_url }
      format.json { head :no_content }
    end
  end
  #role management
  #admin
  #supervisor
  #mrtaadmin
  #author
  #assign_supervisor_role_admin_user
  def assign_supervisor_role
    @user = User.find(params[:id])
    @user.add_role :supervisor
    redirect_to admin_users_path
  end
  #remove_supervisor_role_admin_user
  def remove_supervisor_role
    @user = User.find(params[:id])
    @user.remove_role :supervisor
    redirect_to admin_users_path
  end
  #assign_mrtaadmin_role_admin_user
  def assign_mrtaadmin_role
    @user = User.find(params[:id])
    @user.add_role :mrtaadmin
    redirect_to admin_users_path
  end
  #remove_mrtaadmin_role_admin_user
  def remove_mrtaadmin_role
    @user = User.find(params[:id])
    @user.remove_role :mrtaadmin
    redirect_to admin_users_path
  end
  #assign_author_role_admin_user
  def assign_author_role
    @user = User.find(params[:id])
    @user.add_role :author
    redirect_to admin_users_path
  end
  #remove_author_role_admin_user
  def remove_author_role
    @user = User.find(params[:id])
    @user.remove_role :author
    redirect_to admin_users_path
  end
end
