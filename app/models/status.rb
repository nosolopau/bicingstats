class Status < ActiveRecord::Base
  def self.create_from_remote
    require 'net/http'
    result = Net::HTTP.get(URI.parse('http://niwi-bicing.appspot.com/api/all'))

    remote_statuses = ActiveSupport::JSON.decode(result)
    remote_statuses.each do |remote_status|
      Status.create(
        :free_space => remote_status["freespace"],
        :available => remote_status["available"],
        :station_id => remote_status["stid"],
        :timestamp => remote_status["timestamp"],
        :name => remote_status["name"]
      )
    end
  end
end
