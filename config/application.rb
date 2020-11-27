require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BiciCouriers
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0 # modified manueally after app:upgrade

    # Added manually to respect former custom configuration
    config.paths.add 'offending/file/parent/directory', eager_load: true #ajouté pour que le webhook stripe fonctionne
    config.action_view.embed_authenticity_token_in_remote_forms = true
    config.assets.paths << "#{Rails.root}/app/assets/videos"
    config.generators do |generate|
      generate.assets false
      generate.helper false
      generate.test_framework :test_unit, fixture: false
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
