require_relative 'boot'

require "active_model/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module Metriolite
  class Application < Rails::Application
    config.api_only = true
    config.load_defaults 5.1
  end
end
