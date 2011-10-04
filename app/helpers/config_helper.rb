# -*- encoding : utf-8 -*-
module ConfigHelper
  CONFIG = {
    :facebook_url => 'http://www.facebook.com/pages/Bibliojobs/252229378152246',
    :twitter_id => 'bibliojobs',
    :site_url => 'http://bibliojobs.net'
  }

  def my_config(item)
    CONFIG[item]
  end
end