require 'refinerycms-base'

module Refinery
  module Registrations
    class Engine < Rails::Engine
      config.to_prepare do
        require 'filters_spam'
      end

      config.after_initialize do
        Refinery::Plugin.register do |plugin|
          plugin.name = "registrations"
          plugin.activity = {
            :class => Registration,
            :title => 'username'
          }
        end
      end
    end
  end
end
