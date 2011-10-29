class StatusesController < ApplicationController
  # GET /statuses
  # GET /statuses.xml
  def index
    @statuses = Status.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @statuses }
      format.json  { render :json => @statuses }
    end
  end

  def update_data
    if params[:token] == 'abda821ss'
      if Status.create_from_remote
        flash[:notice] = "Data updated"
      else
        flash[:notice] = "Data not updated. Please wait a few minutes"
      end
    else
      flash[:notice] = "Error"
    end
    
    redirect_to root_url
  end
end
