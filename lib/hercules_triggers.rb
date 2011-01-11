module Hercules
  class Triggers
    def self.before_deploy(options)
      cmd = options[:shell]
      cmd.run "cp config/database.sample.yml config/database.yml"
      cmd.run "mv log/* /home/portal_inafag/logs/"
      cmd.run "rm -rf log"
      cmd.run "ln -s /home/portal_inafag/logs log"
    end
    def self.after_deploy(options)
      cmd = options[:shell]
      cmd.run "kill -HUP `cat /home/portal_inafag/pids/unicorn_production.pid`"
    end
  end
end
