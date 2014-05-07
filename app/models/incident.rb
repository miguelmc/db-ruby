# == Schema Information
#
# Table name: incidents
#
#  incident_id  :integer          default(0), not null, primary key
#  u_id         :integer          not null
#  encargado    :integer          not null
#  catalog      :integer          not null
#  tipo         :string(255)      not null
#  descripcion  :string(1023)     not null
#  fecha_inicio :date
#  fecha_final  :date
#  estado       :string(15)       not null
#  prioridad    :string(10)       not null
#

class Incident < ActiveRecord::Base
  belongs_to :user
  has_one :catalog
  has_many :attempts
end
