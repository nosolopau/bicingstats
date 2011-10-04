# -*- encoding : utf-8 -*-
class Admin::AdminSessionsController < ApplicationController
  # GET /admin_sessions/new
  # GET /admin_sessions/new.xml
  def new
    @admin_session = AdminSession.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin_session }
    end
  end

  # POST /admin_sessions
  # POST /admin_sessions.xml
  def create
    @admin_session = AdminSession.new(params[:admin_session])

    respond_to do |format|
      if @admin_session.save
        format.html { redirect_to(admin_root_url, :notice => t('common.logged in')) }
        format.xml  { render :xml => @admin_session, :status => :created, :location => @admin_session }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin_session.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_sessions/1
  # DELETE /admin_sessions/1.xml
  def destroy
    @admin_session = AdminSession.find
    @admin_session.destroy

    respond_to do |format|
        format.html { redirect_to(admin_root_url, :notice => t('common.logged out')) }
      format.xml  { head :ok }
    end
  end
end
