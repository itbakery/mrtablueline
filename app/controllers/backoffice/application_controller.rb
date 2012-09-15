class Backoffice::ApplicationController < ApplicationController
  layout 'backoffice'
  before_filter :authenticate_user!
   #load_and_authorize_resource

  def index
  end
  protected

    def ckeditor_filebrowser_scope(options = {})
      super({ :assetable_id => current_user.id, :assetable_type => 'User' }.merge(options))
    end
end
