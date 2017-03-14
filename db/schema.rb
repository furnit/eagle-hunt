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

ActiveRecord::Schema.define(version: 20170314192727) do

  create_table "const_consts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float    "guni",       limit: 24
    t.float    "chasb",      limit: 24
    t.float    "sage",       limit: 24
    t.float    "mixkub",     limit: 24
    t.float    "extra",      limit: 24
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "fabric_colors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "fabric_id"
    t.string   "name"
    t.text     "comment",    limit: 65535
    t.json     "images"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["fabric_id"], name: "index_fabric_colors_on_fabric_id", using: :btree
  end

  create_table "fabrics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.float    "cost",       limit: 24
    t.string   "comment"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "furniture_fabric_sections", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "furniture_supports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.float    "cost",       limit: 24
    t.string   "comment"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "furniture_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "comment",         limit: 65535
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.json     "images"
    t.boolean  "is_inside_type",                default: false
    t.boolean  "is_outside_type",               default: false
  end

  create_table "furniture_wood_sections", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "furnitures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.json     "images"
    t.boolean  "available"
    t.string   "comment",           limit: 140
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "furniture_type_id"
    t.text     "description",       limit: 65535
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_furnitures_on_deleted_at", using: :btree
    t.index ["furniture_type_id"], name: "index_furnitures_on_furniture_type_id", using: :btree
  end

  create_table "profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "contact"
    t.text     "address",     limit: 65535
    t.json     "avatar"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "postal_code"
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "shopping_carts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "furniture_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["furniture_id"], name: "index_shopping_carts_on_furniture_id", using: :btree
    t.index ["user_id", "furniture_id"], name: "index_shopping_carts_on_user_id_and_furniture_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_shopping_carts_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "username",               default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.integer  "auth_level",             default: 1,  null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "profile_id"
    t.datetime "deleted_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
    t.index ["profile_id"], name: "index_users_on_profile_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  end

  create_table "wood_colors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "wood_id"
    t.string   "name"
    t.text     "comment",    limit: 65535
    t.json     "images"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["wood_id"], name: "index_wood_colors_on_wood_id", using: :btree
  end

  create_table "woods", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.float    "cost",       limit: 24
    t.string   "comment"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_foreign_key "fabric_colors", "fabrics"
  add_foreign_key "furnitures", "furniture_types"
  add_foreign_key "profiles", "users"
  add_foreign_key "shopping_carts", "furnitures"
  add_foreign_key "shopping_carts", "users"
  add_foreign_key "users", "profiles"
  add_foreign_key "wood_colors", "woods"
end
