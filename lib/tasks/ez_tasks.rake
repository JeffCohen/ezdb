namespace :db do

  namespace :migrate do

    desc "Preview table updates"
    task :preview => :environment do
      if File.exists?('db/models.yml')
        EZDB::DomainModeler.update_tables(false, true)
      else
        puts "Nothing to preview."
      end
    end

  end
end

namespace :ezdb do

  desc "Generate models.yml if it doesn't exist yet."
  task :generate_yml => :environment do
    if EZDB::DomainModeler.generate_models_yml
      puts "You can now edit the db/models.yml file to describe your table schema."
    end
  end

  desc "Deletes the db/models.yml file."
  task :remove_yml do
    if File.exists?('db/models.yml')
      File.delete('db/models.yml')
      puts "Deleted db/models.yml"
    end
  end


  desc "Updates the database schema and your model files."
  task :reset => [:remove_yml, :generate_yml] do
  end

  desc "Updates the database schema and your model files."
  task :update_tables => :environment do
    puts "ezdb:update_tables..."

    if File.exists?('db/models.yml')
      puts "updating tables based on db/models.yml ..."
      if EZDB::DomainModeler.update_tables
        Rake::Task["db:schema:dump"].invoke unless Rails.env.production?
      end
    else
      if EZDB::DomainModeler.generate_models_yml
        puts "You can now edit the db/models.yml file to describe your database schema."
      end
    end
  end

end
