class InitialDbMigration < ActiveRecord::Migration
  def up
    sql = File.read('db/initial_db_config.sql')
    statements = sql.split(/;$/)
    statements.pop

    statements.each do |statement|
      execute(statement)
    end
  end

  def down
    drop_table :users
    drop_table :employees
    drop_table :catalogs
    drop_table :incidents
    drop_table :attempts
  end
end
