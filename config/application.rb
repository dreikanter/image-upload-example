require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ImageUploadExample
  class Application < Rails::Application
    config.autoload_paths += %w(app lib).map { |p| Rails.root.join p }
    config.autoload_paths << 'app/uploaders'

    config.active_job.queue_adapter = :delayed_job

    config.action_cable.mount_path = '/cable'

    config.generators do |g|
      g.test_framework :minitest, spec: false, fixture: false
      g.helper       false
      g.decorator    false
      g.assets       false
      g.stylesheets  false
      g.javascripts  false
      g.view_specs   false
      g.helper_specs false
      g.skip_routes  true
    end

    config.lograge.enabled = true
    config.lograge.custom_options = lambda do |event|
      params = event.payload[:params].except('controller', 'action')
      { params: params } unless params.empty?
    end

    config.action_view.embed_authenticity_token_in_remote_forms = true
  end
end
