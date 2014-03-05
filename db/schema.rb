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

ActiveRecord::Schema.define(version: 20131124230237) do

  create_table "authentications", force: true do |t|
    t.integer  "user_id",    null: false
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cookbooks", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "cookbooks", ["user_id"], name: "index_cookbooks_on_user_id", using: :btree

  create_table "recipe_photos", force: true do |t|
    t.string   "photo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "recipe_id"
  end

  add_index "recipe_photos", ["recipe_id"], name: "index_recipe_photos_on_recipe_id", using: :btree

  create_table "recipes", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "cookbook_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "time"
    t.string   "guests"
    t.string   "difficulty"
  end

  add_index "recipes", ["cookbook_id"], name: "index_recipes_on_cookbook_id", using: :btree
  add_index "recipes", ["user_id"], name: "index_recipes_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username",                        null: false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "avatar"
  end

  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree

end
