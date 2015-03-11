class ActiveRecord::Base

  def self.to_ezdb
    s = self.name + ":\n"
    columns.each do |column|
      default_value = column.default ? "(#{column.default})" : ""
      s <<  "  #{column.name}: #{column.type}#{default_value}\n" unless column.name == 'id'
    end
    s
  end

  def self.dump_all_models_to_ezdb
    s = ""
    (connection.tables - ['schema_migrations']).each do |table|
      s << table.classify.constantize.to_ezdb << "\n"
    end
    s
  end

end
