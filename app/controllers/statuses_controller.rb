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
end
