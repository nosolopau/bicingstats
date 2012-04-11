class Sample < ActiveRecord::Base
  has_many :statuses

  def stats
    empty_stations = 0
    available = 0
    free_space = 0
    not_empty_stations = 0

    self.statuses.each do |status|
      available += status.available
      free_space += status.free_space
      if status.available == 0
        empty_stations += 1
      else
        not_empty_stations += 1
      end
    end

    {:empty_stations => empty_stations, :available => available, :free_space => free_space, :not_empty_stations => not_empty_stations}
  end

  def self.create_from_remote
    begin
      result = Net::HTTP.get(URI.parse(Bicing::Application.config.global["samples_service_url"]))
      remote_statuses = ActiveSupport::JSON.decode(result)
      time = Time.now
      conversor = Iconv.new('UTF-8', 'WINDOWS-1252')

      sample = Sample.create
      remote_statuses.each do |remote_status|
        status = Status.new(
          :free_space => remote_status["foratsBuits"].to_i,
          :available => remote_status["foratsPlens"].to_i,
          :station_id => remote_status["id"],
          :timestamp => time,
          :coordinates => "#{remote_status['x']}, #{remote_status['y']}",
          :name => conversor.conv(remote_status["direccio"])
        )
        status.sample = sample
        status.save
      end

      true
    rescue
      false
    end
  end
end
