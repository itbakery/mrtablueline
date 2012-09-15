class Admin::PagesController < ApplicationController
  before_filter :get_rootspage
  # GET /admin/pages
  # GET /admin/pages.json
  def index
    @admin_pages = Admin::Page.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_pages }
    end
  end

  # GET /admin/pages/1
  # GET /admin/pages/1.json
  def show
    @admin_page = Admin::Page.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_page }
    end
  end

  # GET /admin/pages/new
  # GET /admin/pages/new.json
  def new
    @admin_page = Admin::Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_page }
    end
  end

  # GET /admin/pages/1/edit
  def edit
    @admin_page = Admin::Page.find(params[:id])
  end

  # POST /admin/pages
  # POST /admin/pages.json
  def create
    @admin_page = Admin::Page.new(params[:admin_page])

    respond_to do |format|
      if @admin_page.save
        format.html { redirect_to @admin_page, notice: 'Page was successfully created.' }
        format.json { render json: @admin_page, status: :created, location: @admin_page }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/pages/1
  # PUT /admin/pages/1.json
  def update
    @admin_page = Admin::Page.find(params[:id])

    respond_to do |format|
      if @admin_page.update_attributes(params[:admin_page])
        format.html { redirect_to @admin_page, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/pages/1
  # DELETE /admin/pages/1.json
  def destroy
    @admin_page = Admin::Page.find(params[:id])
    @admin_page.destroy

    respond_to do |format|
      format.html { redirect_to admin_pages_url }
      format.json { head :no_content }
    end
  end
  private
  def get_rootspage
    @pageroots = Admin::Page.roots
  end

end
