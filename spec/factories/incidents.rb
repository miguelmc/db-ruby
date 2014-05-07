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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :incident do
  end
end
