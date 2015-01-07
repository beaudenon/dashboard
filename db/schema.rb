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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121015205052) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "events", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "secubat_clients", :force => true do |t|
    t.string   "gender",        :limit => 0, :default => "monsieur"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "entreprise"
    t.text     "description"
    t.boolean  "mailing_voeux"
    t.boolean  "is_admin",                   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "secubat_mailings", :force => true do |t|
    t.integer  "secubat_client_id"
    t.integer  "secubat_model_id"
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",            :default => "pending"
    t.text     "last_error"
  end

  create_table "secubat_models", :force => true do |t|
    t.string   "subject"
    t.string   "body"
    t.string   "filename"
    t.text     "description"
    t.boolean  "is_unique",    :default => true
    t.string   "template"
    t.boolean  "is_activated", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", :force => true do |t|
    t.string   "name"
    t.integer  "position"
    t.string   "color"
    t.decimal  "progress",   :precision => 5, :scale => 2, :default => 0.0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "todos", :force => true do |t|
    t.integer  "project_id"
    t.string   "title"
    t.string   "url"
    t.text     "description"
    t.datetime "to_begin_at"
    t.integer  "status_id"
    t.integer  "importance",                                   :default => 1
    t.integer  "emergency",                                    :default => 1
    t.integer  "estimated_time",                               :default => 0
    t.decimal  "progress",       :precision => 5, :scale => 2, :default => 0.0, :null => false
    t.integer  "past_time",                                    :default => 0
    t.datetime "finished_at"
    t.integer  "position",                                     :default => 1
    t.integer  "difficulty",                                   :default => 1
    t.integer  "timer",                                        :default => 0
    t.datetime "archived_at"
    t.integer  "type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deadline"
  end

  create_table "types", :force => true do |t|
    t.string   "name"
    t.integer  "position"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "urls", :force => true do |t|
    t.string   "url"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "visits", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "weddings", :force => true do |t|
    t.string   "titre"
    t.text     "description"
    t.string   "lieu"
    t.datetime "date"
    t.integer  "duree"
    t.string   "personne"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
