# == Schema Information
#
# Table name: attempts
#
#  attempt_id   :integer          default(0), not null, primary key
#  fecha_inicio :date
#  fecha_final  :date
#  e_id         :integer          not null
#  i_id         :integer          not null
#  comentario   :string(1023)     not null
#

class Attempt < ActiveRecord::Base
  belongs_to :incident
  has_many :employees
end
