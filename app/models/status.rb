class Status < ActiveRecord::Base
  def self.create_from_remote
    if (Status.last == nil) || (Status.last && (Time.now > Status.last.timestamp + 5.minute))
      begin
        result = Net::HTTP.get(URI.parse('http://rocboronat.net/barcelonabicing/bcnJ?all=1'))
        remote_statuses = ActiveSupport::JSON.decode(result)
        time = Time.now
        conversor = Iconv.new('UTF-8', 'WINDOWS-1252')

        remote_statuses.each do |remote_status|
          Status.create(
            :free_space => remote_status["foratsPlens"].to_i,
            :available => remote_status["foratsBuits"].to_i,
            :station_id => remote_status["id"],
            :timestamp => time,
            :coordinates => "#{remote_status['x']}, #{remote_status['y']}",
            :name => conversor.conv(remote_status["direccio"])
          )
        end

        true
      rescue
        false
      end
    else
      false
    end
  end
end
