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

ActiveRecord::Schema.define(version: 20170309202528) do

  create_table "colors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "comment",    limit: 65535
    t.float    "cost",       limit: 24
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "furniture_costs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "furniture_id"
    t.float    "rokob_sage",           limit: 24
    t.float    "rokob_garni",          limit: 24
    t.float    "rokob_abr",            limit: 24
    t.float    "dast_mozd",            limit: 24
    t.float    "khayat_parche",        limit: 24
    t.float    "khayat_kosan_parche",  limit: 24
    t.float    "khayat_kosan_abr",     limit: 24
    t.float    "khayat_poshti_parche", limit: 24
    t.float    "khayat_poshti_abr",    limit: 24
    t.float    "khayat_ziri_parche",   limit: 24
    t.float    "khayat_ziri_abr",      limit: 24
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["furniture_id"], name: "index_furniture_costs_on_furniture_id", using: :btree
  end

  create_table "furniture_frame_color_costs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "furniture_id"
    t.integer  "color_id"
    t.float    "amount",       limit: 24
    t.float    "wage",         limit: 24
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["color_id"], name: "index_furniture_frame_color_costs_on_color_id", using: :btree
    t.index ["furniture_id"], name: "index_furniture_frame_color_costs_on_furniture_id", using: :btree
  end

  create_table "furniture_frame_skeleton_costs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "furniture_id"
    t.integer  "wood_id"
    t.float    "amount",       limit: 24
    t.float    "wage",         limit: 24
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["furniture_id"], name: "index_furniture_frame_skeleton_costs_on_furniture_id", using: :btree
    t.index ["wood_id"], name: "index_furniture_frame_skeleton_costs_on_wood_id", using: :btree
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

  create_table "furnitures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.json     "images"
    t.boolean  "available"
    t.string   "comment",           limit: 140
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "furniture_type_id"
    t.text     "description",       limit: 65535
    t.integer  "count_ziri",                      default: 0
    t.integer  "count_kosan",                     default: 0
    t.integer  "count_poshti",                    default: 0
    t.boolean  "check_lamse",                     default: false
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

  create_table "woods", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "comment",    limit: 65535
    t.float    "cost",       limit: 24
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_foreign_key "furniture_costs", "furnitures"
  add_foreign_key "furniture_frame_color_costs", "colors"
  add_foreign_key "furniture_frame_color_costs", "furnitures"
  add_foreign_key "furniture_frame_skeleton_costs", "furnitures"
  add_foreign_key "furniture_frame_skeleton_costs", "woods"
  add_foreign_key "furnitures", "furniture_types"
  add_foreign_key "profiles", "users"
  add_foreign_key "shopping_carts", "furnitures"
  add_foreign_key "shopping_carts", "users"
  add_foreign_key "users", "profiles"
end
