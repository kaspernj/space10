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

ActiveRecord::Schema.define(version: 20151013202616) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "name"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "zipcode"
    t.string   "city"
    t.string   "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "content_blocks", force: :cascade do |t|
    t.string   "type"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "row_order"
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.text     "excerpt"
    t.text     "content"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "address_id"
    t.datetime "publish_at"
    t.boolean  "published"
    t.integer  "max_registrations"
  end

  create_table "image_attachments", force: :cascade do |t|
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "image"
    t.integer  "row_order"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "excerpt"
  end

  create_table "registrations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.boolean  "confirmed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "text_attachments", force: :cascade do |t|
    t.string   "resource_type"
    t.integer  "resource_id"
    t.text     "content"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "auth_token"
    t.boolean  "admin",           default: false
  end

  create_table "video_attachments", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.boolean  "featured"
    t.string   "provider"
    t.string   "video_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "video_url"
    t.string   "resource_type"
    t.integer  "resource_id"
  end

end
