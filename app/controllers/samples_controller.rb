class SamplesController < ApplicationController
  # GET /samples
  # GET /samples.xml
  def index
    @samples = Sample.paginate(:page => params[:page]).order('timestamp desc')

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

  def update_data
    if params[:token] == 'abda821ss'
      if Sample.create_from_remote
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
