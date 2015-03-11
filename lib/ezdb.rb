require "ezdb/version"
require 'ezdb/domain_modeler.rb'
require 'ezdb/model.rb'

module EZDB
  module Console
    def reload!(print=true)
      if print
        puts "Reloading code..."
        puts "Checking models.yml for model changes..."
      end

      ActionDispatch::Reloader.cleanup!
      ActionDispatch::Reloader.prepare!

      old_level = ActiveRecord::Base.logger.level
      ActiveRecord::Base.logger.level = Logger::WARN

      yml_created = EZDB::DomainModeler.generate_models_yml
      if !yml_created
        updated = EZDB::DomainModeler.update_tables
        EZDB::DomainModeler.dump_schema if updated
      end

      ActiveRecord::Base.logger.level = old_level

      if yml_created || updated
        puts "Models: #{EZDB::DomainModeler.models.to_sentence}"
      else
        puts "No model changes detected."
      end

      true
    end
  end
end

module EZDB

  class Railtie < Rails::Railtie

    rake_tasks do
      load "tasks/ez_tasks.rake"
      Rake::Task["db:migrate"].enhance ["ezdb:update_tables"]
    end

    console do |app|
      Rails::ConsoleMethods.send :prepend, EZDB::Console

      # force connection to make it easier to start using models
      ActiveRecord::Base.connection
    end

  end
end
