class SamplesController < ApplicationController
  # GET /samples
  # GET /samples.xml
  def index
    @samples = Sample.paginate(:page => params[:page]).order('created_at desc')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @samples }
      format.json { render :json => @samples }
    end
  end

  # GET /samples/1
  # GET /samples/1.xml
  def show
    @sample = Sample.find(params[:id])
    @stats = @sample.stats

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sample }
      format.json { render :json => @sample }
    end
  end

  # GET /update_data?token=123
  # GET /update_data.xml?token=123
  def update_data
    if token_is_valid?
      if Sample.create_from_remote
        flash[:notice] = "Data updated"
      else
        flash[:notice] = "Data not updated. Please wait a few minutes"
      end
    else
      flash[:notice] = "Error"
    end

    respond_to do |format|
      format.html { redirect_to root_url }
      format.xml  { head :ok }
      format.json { head :ok }
    end
    
  end

private

  def token_is_valid?
    params[:token] == Bicing::Application.config.global["token"]
  end
end
