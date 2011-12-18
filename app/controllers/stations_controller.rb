class StationsController < ApplicationController
  def show
    @station = params[:id]
    @statuses = Status.where(:station_id => @station).paginate(:page => params[:page]).order('timestamp desc')
  end
end