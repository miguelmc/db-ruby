# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140425140722) do

  create_table "attempts", primary_key: "attempt_id", force: true do |t|
    t.date    "fecha_inicio"
    t.date    "fecha_final"
    t.integer "e_id",                      null: false
    t.integer "i_id",                      null: false
    t.string  "comentario",   limit: 1023, null: false
  end

  add_index "attempts", ["e_id"], name: "e_id", using: :btree
  add_index "attempts", ["i_id"], name: "i_id", using: :btree

  create_table "catalogs", primary_key: "catalog_id", force: true do |t|
    t.string "area"
    t.string "name"
  end

  create_table "employees", primary_key: "employee_id", force: true do |t|
    t.string "name",            null: false
    t.string "mail",            null: false
    t.string "password_digest", null: false
  end

  create_table "incidents", primary_key: "incident_id", force: true do |t|
    t.integer "u_id",                                          null: false
    t.integer "encargado"
    t.integer "catalog"
    t.string  "descripcion",  limit: 1023,                     null: false
    t.date    "fecha_inicio"
    t.date    "fecha_final"
    t.string  "estado",       limit: 15,   default: "ABIERTO", null: false
    t.string  "prioridad",    limit: 10,   default: "MEDIA",   null: false
  end

  add_index "incidents", ["catalog"], name: "catalog", using: :btree
  add_index "incidents", ["encargado"], name: "encargado", using: :btree
  add_index "incidents", ["u_id"], name: "u_id", using: :btree

  create_table "users", primary_key: "user_id", force: true do |t|
    t.string "name",            null: false
    t.string "mail",            null: false
    t.string "password_digest", null: false
  end

end
