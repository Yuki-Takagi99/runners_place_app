require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RunnersPlaceApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.i18n.default_locale = :ja
    config.time_zone = 'UTC'
    config.active_record.default_timezone :utc
    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: false,
        request_specs: false
      g.fixture_replacement :factory_bot, dir: "spec/factories"
    end
    # Carrier wave導入後のエラー回避のため追記
    config.autoload_paths += Dir[Rails.root.join('app', 'uploaders')]
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # システムスペック時のエラー解消のため追記
    config.assets.precompile += %w(*.eot *.svg *.ttf *.woff)
    config.assets.paths << "#{Rails}/vendor/assets/fonts"
  end
end
