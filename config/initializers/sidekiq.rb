require 'sidekiq'
require 'sidekiq/web'
require 'sidekiq-scheduler'
require 'sidekiq-scheduler/web'

class ConfigParser
  def self.parse(file, environment)
    YAML.load(ERB.new(IO.read(file)).result)[environment]
  end
end

Sidekiq.configure_server do |config|
  config.on(:startup) do
    SidekiqScheduler::Scheduler.instance.rufus_scheduler_options = { max_work_threads: 1 }
    Sidekiq.schedule = ConfigParser.parse(File.join(Rails.root, 'config/scheduler.yml'), Rails.env)
    SidekiqScheduler::Scheduler.instance.reload_schedule!
  end
end

Sidekiq.configure_server do |config|
  config.redis = { url: Rails.application.credentials.REDIS_URL }
end
Sidekiq.configure_client do |config|
  config.redis = { url: Rails.application.credentials.REDIS_URL }
end
