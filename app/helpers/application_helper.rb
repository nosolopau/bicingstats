module ApplicationHelper
  def pagination(what)
    "#{will_paginate what, :id => 'paginator', :class => 'apple_pagination'}".html_safe
  end
end
