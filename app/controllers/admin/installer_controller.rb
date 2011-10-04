# -*- encoding : utf-8 -*-
class Admin::InstallerController < ApplicationController
  def index
    unless Admin.all.empty?
      flash[:notice] = 'Ya existe un administrador'
      redirect_to(admin_login_path)
    else
      @admin = Admin.new

      if params[:admin]
        @admin = Admin.new(params[:admin])

        if @admin.save
          redirect_to([:admin, @admin], :notice => 'Admin was successfully created.')
        else
          render :action => "index"
        end
      end
    end
  end 
end
