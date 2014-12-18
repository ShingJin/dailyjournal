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

ActiveRecord::Schema.define(version: 20141217102346) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "entries", force: true do |t|
    t.text     "entry_text"
    t.string   "contact"
    t.string   "tags",       array: true
    t.string   "case"
    t.boolean  "visibility"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "friendships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "homes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plans", force: true do |t|
    t.integer  "plan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "shop_email"
  end

  create_table "rulepays", force: true do |t|
    t.boolean  "paid"
    t.integer  "amount"
    t.string   "identifier"
    t.datetime "starting_date"
    t.datetime "ending_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "rules", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "product_ids",                    array: true
    t.string   "collection_ids",                 array: true
    t.string   "tag_ids",                        array: true
    t.boolean  "by_percentage"
    t.integer  "per_product"
    t.integer  "per_order"
    t.integer  "raised",         default: 0
    t.string   "timeframe"
    t.integer  "amount_due",     default: 0
    t.boolean  "paid",           default: false
    t.datetime "starting_date"
    t.datetime "ending_date"
    t.string   "tags",                           array: true
    t.string   "identifier"
    t.string   "frequency"
    t.integer  "shop_id"
    t.string   "domain"
    t.boolean  "permanent"
    t.string   "link"
    t.integer  "payments",                       array: true
    t.integer  "paid_amount",    default: 0
    t.boolean  "notified"
    t.datetime "first_created"
  end

  create_table "shops", force: true do |t|
    t.string   "domain"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "frequency"
    t.string   "wtitle"
    t.text     "wtext"
    t.integer  "total"
    t.string   "email"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "site"
    t.string   "token"
    t.string   "email"
    t.string   "visible_names", array: true
    t.string   "auth_token"
    t.string   "password_salt"
    t.string   "password_hash"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
