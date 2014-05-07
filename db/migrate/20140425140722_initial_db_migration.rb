class InitialDbMigration < ActiveRecord::Migration
  def up
    sql = File.read('db/initial_db_config.sql')
    statements = sql.split(/;$/)
    statements.pop

    statements.each do |statement|
      execute(statement)
    end
  end
end
