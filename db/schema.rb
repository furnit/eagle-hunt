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

ActiveRecord::Schema.define(version: 20170411080030) do

  create_table "admin_furniture_scales", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_furniture_sections", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "comment"
    t.json     "images"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_furniture_specs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_furniture_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "comment",         limit: 65535
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.json     "images"
    t.boolean  "is_inside_type",                default: false
    t.boolean  "is_outside_type",               default: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_admin_furniture_types_on_deleted_at", using: :btree
  end

  create_table "admin_furnitures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.json     "images"
    t.boolean  "available"
    t.string   "comment",           limit: 140
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "furniture_type_id"
    t.text     "description",       limit: 65535
    t.datetime "deleted_at"
    t.json     "cover_details"
    t.string   "description_html"
    t.index ["deleted_at"], name: "index_admin_furnitures_on_deleted_at", using: :btree
    t.index ["furniture_type_id"], name: "index_admin_furnitures_on_furniture_type_id", using: :btree
  end

  create_table "admin_user_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "comment",    limit: 65535
    t.string   "symbol"
    t.integer  "auth_level"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["name"], name: "index_admin_user_types_on_name", unique: true, using: :btree
    t.index ["symbol"], name: "index_admin_user_types_on_symbol", unique: true, using: :btree
  end

  create_table "const_consts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float    "guni",       limit: 24
    t.float    "chasb",      limit: 24
    t.float    "sage",       limit: 24
    t.float    "mixkub",     limit: 24
    t.float    "extra",      limit: 24
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "employee_admins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employee_fani_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "employee_fanis_id"
    t.integer  "furniture_build_detail_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["employee_fanis_id"], name: "index_employee_fani_details_on_employee_fanis_id", using: :btree
    t.index ["furniture_build_detail_id"], name: "index_employee_fani_details_on_furniture_build_detail_id", using: :btree
  end

  create_table "employee_fanis", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "furnitures_id"
    t.integer  "users_id"
    t.float    "wage_rokob",       limit: 24
    t.float    "wage_khayat",      limit: 24
    t.boolean  "confirmed",                   default: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.boolean  "needs_kande",                 default: false
    t.boolean  "needs_kanaf",                 default: false
    t.boolean  "needs_rang",                  default: false
    t.integer  "days_to_complete",            default: -1
    t.index ["furnitures_id"], name: "index_employee_fanis_on_furnitures_id", using: :btree
    t.index ["users_id"], name: "index_employee_fanis_on_users_id", using: :btree
  end

  create_table "furniture_build_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "admin_furniture_sections_id"
    t.integer  "admin_furniture_specs_id"
    t.float    "value",                       limit: 24
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["admin_furniture_sections_id"], name: "index_furniture_build_details_on_admin_furniture_sections_id", using: :btree
    t.index ["admin_furniture_specs_id"], name: "index_furniture_build_details_on_admin_furniture_specs_id", using: :btree
  end

  create_table "profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "address",     limit: 65535
    t.json     "avatar"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "postal_code"
    t.integer  "state_id"
    t.index ["state_id"], name: "index_profiles_on_state_id", using: :btree
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

  create_table "states", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_states_on_name", unique: true, using: :btree
  end

  create_table "uploaded_files", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.json     "images"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                     default: "",    null: false
    t.string   "encrypted_password",        default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",           default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.datetime "deleted_at"
    t.integer  "admin_user_type_id",        default: 2
    t.datetime "blocked_at"
    t.string   "phone_number",              default: "",    null: false
    t.integer  "creator_user_id"
    t.boolean  "change_password",           default: false
    t.boolean  "is_added_to_phonebook",     default: false
    t.boolean  "error_on_add_to_phonebook", default: false
    t.index ["admin_user_type_id"], name: "index_users_on_admin_user_type_id", using: :btree
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["creator_user_id"], name: "index_users_on_creator_user_id", using: :btree
    t.index ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  end

  add_foreign_key "admin_furnitures", "admin_furniture_types", column: "furniture_type_id"
  add_foreign_key "employee_fani_details", "employee_fanis", column: "employee_fanis_id"
  add_foreign_key "employee_fani_details", "furniture_build_details"
  add_foreign_key "furniture_build_details", "admin_furniture_sections", column: "admin_furniture_sections_id"
  add_foreign_key "furniture_build_details", "admin_furniture_specs", column: "admin_furniture_specs_id"
  add_foreign_key "profiles", "states"
  add_foreign_key "profiles", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "shopping_carts", "admin_furnitures", column: "furniture_id"
  add_foreign_key "shopping_carts", "users"
  add_foreign_key "users", "admin_user_types"
end
