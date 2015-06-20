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

ActiveRecord::Schema.define(version: 20150620144828) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", unique: true, using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "galleries", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "cover"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: true do |t|
    t.integer  "user_id"
    t.string   "slug"
    t.text     "content"
    t.boolean  "published",        default: false
    t.text     "meta_description"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  add_index "pages", ["user_id"], name: "index_pages_on_user_id", using: :btree

  create_table "pictures", force: true do |t|
    t.string   "description"
    t.string   "image"
    t.integer  "gallery_id"
    t.string   "gallery_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "slug"
    t.text     "content"
    t.boolean  "published",         default: false
    t.string   "permalink_path"
    t.datetime "published_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "protect_slug",      default: false
    t.text     "meta_description"
    t.string   "image_url_string"
    t.boolean  "url_contains_date", default: false
    t.string   "subtitle"
  end

  add_index "posts", ["slug"], name: "index_posts_on_slug", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "role"
    t.string   "slug"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.string   "encrypted_password",     limit: 128, default: "", null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "access_token"
    t.string   "access_secret"
  end

  add_index "users", ["slug"], name: "index_users_on_slug", using: :btree

end
