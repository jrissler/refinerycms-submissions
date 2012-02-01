require File.expand_path('../inquiries', __FILE__)

module Refinery
  module Submissions
    class Engine < Rails::Engine
      config.after_initialize do
        Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name = "refinery_submissions"
          plugin.directory = "submissions"
          plugin.menu_match = /(refinery|admin)\/submission(s|y_settings)$/
        end
      end
    end
  end
end