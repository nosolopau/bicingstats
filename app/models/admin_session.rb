# -*- encoding : utf-8 -*-
class AdminSession < Authlogic::Session::Base
  include ActiveModel::Conversion
  def persisted?
    false
  end
end
