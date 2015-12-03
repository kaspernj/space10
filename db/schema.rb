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

ActiveRecord::Schema.define(version: 20151203155134) do

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

  add_index "content_blocks", ["resource_id", "resource_type"], name: "index_content_blocks_on_resource_id_and_resource_type", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.text     "excerpt"
    t.text     "content"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "address_id"
    t.datetime "publish_at"
    t.boolean  "published"
    t.integer  "max_registrations"
    t.string   "slug"
    t.integer  "lab_id"
    t.text     "project_partners_text"
    t.text     "project_people_text"
  end

  add_index "events", ["slug"], name: "index_events_on_slug", unique: true, using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

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

  add_index "image_attachments", ["resource_id", "resource_type"], name: "index_image_attachments_on_resource_id_and_resource_type", using: :btree

  create_table "labs", force: :cascade do |t|
    t.string   "title"
    t.string   "subtitle"
    t.boolean  "published"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "logo_attachments", force: :cascade do |t|
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "image"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "logo_attachments", ["resource_id", "resource_type"], name: "index_logo_attachments_on_resource_id_and_resource_type", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.text     "excerpt"
    t.text     "content"
    t.datetime "publish_at"
    t.boolean  "published"
    t.integer  "lab_id"
    t.text     "project_partners_text"
    t.text     "project_people_text"
    t.string   "slug"
  end

  add_index "posts", ["slug"], name: "index_posts_on_slug", unique: true, using: :btree

  create_table "profile_authorizations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "location"
    t.string   "type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.boolean  "published"
    t.string   "image"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "website"
    t.boolean  "featured"
    t.string   "email"
    t.string   "slug"
    t.string   "tagline"
  end

  add_index "profiles", ["slug"], name: "index_profiles_on_slug", unique: true, using: :btree

  create_table "project_partnerships", force: :cascade do |t|
    t.string   "resource_type"
    t.integer  "resource_id"
    t.integer  "partner_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "person_id"
    t.string   "type"
  end

  add_index "project_partnerships", ["resource_id", "resource_type"], name: "index_project_partnerships_on_resource_id_and_resource_type", using: :btree

  create_table "registrations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.boolean  "confirmed",  default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "taggings", ["resource_id", "resource_type"], name: "index_taggings_on_resource_id_and_resource_type", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "title"
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

  add_index "text_attachments", ["resource_id", "resource_type"], name: "index_text_attachments_on_resource_id_and_resource_type", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "auth_token"
    t.boolean  "admin",           default: false
    t.string   "name"
    t.date     "birthday"
    t.string   "gender"
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
    t.string   "image"
  end

end
