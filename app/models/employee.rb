# == Schema Information
#
# Table name: employees
#
#  employee_id     :integer          default(0), not null, primary key
#  name            :string(255)      not null
#  mail            :string(255)      not null
#  password_digest :string(255)      not null
#

class Employee < ActiveRecord::Base
  has_many :incidents
  has_secure_password
  validate :mail, uniqueness: true
end
