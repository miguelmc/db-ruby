# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

connection = ActiveRecord::Base.connection

# user insertions -------------------------

@user = User.new(name: "Miguel", mail: "miguel@correo.com", password: "password", password_confirmation: "password")

sql1 = "INSERT INTO users (user_id, name, mail, password_digest) VALUES (1, '#{@user.name}', '#{@user.mail}', '#{@user.password_digest}');"

@user = User.new(name: "Luis", mail: "luis@correo.com", password: "password", password_confirmation: "password")

sql2 = "INSERT INTO users (user_id, name, mail, password_digest) VALUES (2, '#{@user.name}', '#{@user.mail}', '#{@user.password_digest}');"

@user = User.new(name: "Diego", mail: "diego@correo.com", password: "password", password_confirmation: "password")

sql3 = "INSERT INTO users (user_id, name, mail, password_digest) VALUES (3, '#{@user.name}', '#{@user.mail}', '#{@user.password_digest}');"

@user = User.new(name: "Roel", mail: "roel@correo.com", password: "password", password_confirmation: "password")

sql4 = "INSERT INTO users (user_id, name, mail, password_digest) VALUES (4, '#{@user.name}', '#{@user.mail}', '#{@user.password_digest}');"

@user = User.new(name: "Ricardo", mail: "ricardo@correo.com", password: "password", password_confirmation: "password")

sql5 = "INSERT INTO users (user_id, name, mail, password_digest) VALUES (5, '#{@user.name}', '#{@user.mail}', '#{@user.password_digest}');"

connection.execute sql1
connection.execute sql2
connection.execute sql3
connection.execute sql4
connection.execute sql5

#-----------------------------------
#employee insetions-----------------

@employee = Employee.new(name: "Elda", mail: "elda@correo.com", password: "password", password_confirmation: "password")

sql1 = "INSERT INTO employees (employee_id, name, mail, password_digest) VALUES (1, '#{@employee.name}', '#{@employee.mail}', '#{@employee.password_digest}');"

@employee = Employee.new(name: "Luis Humberto", mail: "lh@correo.com", password: "password", password_confirmation: "password")

sql2 = "INSERT INTO employees (employee_id, name, mail, password_digest) VALUES (2, '#{@employee.name}', '#{@employee.mail}', '#{@employee.password_digest}');"

@employee = Employee.new(name: "Moraima", mail: "moraima@correo.com", password: "password", password_confirmation: "password")

sql3 = "INSERT INTO employees (employee_id, name, mail, password_digest) VALUES (3, '#{@employee.name}', '#{@employee.mail}', '#{@employee.password_digest}');"

@employee = Employee.new(name: "Antonio", mail: "mejorado@correo.com", password: "password", password_confirmation: "password")

sql4 = "INSERT INTO employees (employee_id, name, mail, password_digest) VALUES (4, '#{@employee.name}', '#{@employee.mail}', '#{@employee.password_digest}');"

connection.execute sql1
connection.execute sql2
connection.execute sql3
connection.execute sql4

#-----------------------------------

sql = File.read('db/insertions.sql')
statements = sql.split(/;$/)
statements.pop

ActiveRecord::Base.transaction do
  statements.each do |statement|
    connection.execute(statement)
  end
end
