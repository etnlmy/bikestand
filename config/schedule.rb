set :job_template, nil

set :output, "#{Whenever.path}/log/cron.log"
env :PATH, ENV['PATH']
env :GEM_HOME, ENV['GEM_HOME']

every 10.minutes do
  rake "db:new_record"
end

every 1.day, :at => '01:00 am' do
  rake "db:elevation"
end