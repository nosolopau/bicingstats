# -*- encoding : utf-8 -*-
class MainController < ApplicationController
  def index
    @jobs = Job.find(:all, :order => "created_at desc", :limit => 10)
    @featured_company = Company.find_featured
    @categories = JobCategory.all
  end
end
