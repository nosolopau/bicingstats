class StatusesController < ApplicationController
  # GET /statuses
  # GET /statuses.xml
  def index
    @sample = Sample.find(params[:sample_id])
    @statuses = @sample.statuses
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @statuses }
      format.json { render :json => @statuses }
    end
  end
end
