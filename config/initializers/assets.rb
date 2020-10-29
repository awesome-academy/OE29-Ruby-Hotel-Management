Rails.application.config.assets.version = ".0"
Rails.application.config.assets.paths << Rails.root.join("node_modules")
Rails.application.config.assets.precompile += %w( mailer.css )
