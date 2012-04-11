class StationsController < ApplicationController
  # GET /stations/1
  # GET /stations/1.xml
  def show
    @station = params[:id]
    @statuses = Status.where(:station_id => @station).paginate(:page => params[:page]).order('timestamp asc')
  end
end