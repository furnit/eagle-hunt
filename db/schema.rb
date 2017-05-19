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

ActiveRecord::Schema.define(version: 20170517163516) do

  create_table "admin_contacts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "phone_numbers", limit: 65535
    t.text     "address",       limit: 65535
    t.text     "comment",       limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "admin_furniture_fabric_brands", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "comment",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "admin_furniture_fabric_color_indices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "admin_furniture_fabric_id"
    t.integer  "admin_furniture_fabric_image"
    t.integer  "admin_furniture_fabric_color_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["admin_furniture_fabric_color_id"], name: "index_column_admin_fabric_color", using: :btree
    t.index ["admin_furniture_fabric_id"], name: "index_column_admin_fabric", using: :btree
  end

  create_table "admin_furniture_fabric_colors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "value",                    null: false
    t.text     "comment",    limit: 65535
    t.json     "model"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["value"], name: "index_admin_furniture_fabric_colors_on_value", unique: true, using: :btree
  end

  create_table "admin_furniture_fabric_cushions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "label"
    t.integer  "width"
    t.integer  "height"
    t.text     "comment",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "admin_furniture_fabric_fabrics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "admin_furniture_fabric_type_id"
    t.integer  "admin_furniture_fabric_brand_id"
    t.text     "comment",                         limit: 65535
    t.json     "images"
    t.json     "images_detail"
    t.datetime "deleted_at"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.index ["admin_furniture_fabric_brand_id"], name: "index_fabric_brand", using: :btree
    t.index ["admin_furniture_fabric_type_id"], name: "index_fabric_type", using: :btree
  end

  create_table "admin_furniture_fabric_models", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "admin_furniture_fabric_fabric_id"
    t.string   "name"
    t.json     "images"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["admin_furniture_fabric_fabric_id"], name: "index_fabric_model_fabric", using: :btree
  end

  create_table "admin_furniture_fabric_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "comment",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "admin_furniture_foam_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_furniture_furnitures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.json     "images"
    t.boolean  "available",                          default: false
    t.string   "comment",              limit: 140
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.integer  "furniture_type_id"
    t.text     "description",          limit: 65535
    t.datetime "deleted_at"
    t.json     "cover_details"
    t.string   "description_html"
    t.boolean  "has_unconfirmed_data",               default: false
    t.datetime "data_locked_at"
    t.integer  "free_cushions",                      default: 0
    t.boolean  "ready_for_pricing"
    t.index ["deleted_at"], name: "index_admin_furniture_furnitures_on_deleted_at", using: :btree
    t.index ["furniture_type_id"], name: "index_admin_furniture_furnitures_on_furniture_type_id", using: :btree
  end

  create_table "admin_furniture_paint_color_brands", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "comment",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "admin_furniture_paint_color_qualities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "comment",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "admin_furniture_paint_colors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "admin_furniture_paint_color_qualities_id"
    t.integer  "admin_furniture_paint_color_brands_id"
    t.text     "comment",                                  limit: 65535
    t.string   "color_value"
    t.json     "color_details"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.index ["admin_furniture_paint_color_brands_id"], name: "index_color_brand", using: :btree
    t.index ["admin_furniture_paint_color_qualities_id"], name: "index_color_quality", using: :btree
  end

  create_table "admin_furniture_pieces", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "piece"
    t.text     "comment",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "admin_furniture_sections", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "comment"
    t.json     "images"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "tag"
  end

  create_table "admin_furniture_sets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.json     "config"
    t.text     "comment",     limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "total_count"
  end

  create_table "admin_furniture_specs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "comment"
    t.string   "unit"
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

  create_table "admin_furniture_wood_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "comment",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "admin_pricing_consts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "guni"
    t.integer  "chasb"
    t.integer  "payemobl"
    t.integer  "sage"
    t.integer  "mikh"
    t.integer  "extra"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_pricing_fabrics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "admin_furniture_fabric_brand_id"
    t.integer  "price"
    t.text     "comment",                         limit: 65535
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.index ["admin_furniture_fabric_brand_id"], name: "index_admin_pricing_fabrics_on_admin_furniture_fabric_brand_id", using: :btree
  end

  create_table "admin_pricing_foams", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "admin_furniture_foam_type_id"
    t.integer  "price"
    t.text     "comment",                      limit: 65535
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.index ["admin_furniture_foam_type_id"], name: "index_admin_pricing_foams_on_admin_furniture_foam_type_id", using: :btree
  end

  create_table "admin_pricing_kalafs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "price"
    t.text     "comment",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "admin_pricing_paint_astar_rouyes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float    "astare_avaliye", limit: 24
    t.float    "astare_asli",    limit: 24
    t.float    "rouye",          limit: 24
    t.float    "batune",         limit: 24
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "admin_pricing_paint_colors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "admin_furniture_paint_color_brand_id"
    t.integer  "price"
    t.text     "comment",                              limit: 65535
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.index ["admin_furniture_paint_color_brand_id"], name: "index_pricing_paint_color_brand", using: :btree
  end

  create_table "admin_pricing_transits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "admin_workshop_workshop_id"
    t.integer  "state_id"
    t.bigint   "price"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["admin_workshop_workshop_id"], name: "index_admin_pricing_transits_on_admin_workshop_workshop_id", using: :btree
    t.index ["state_id"], name: "index_admin_pricing_transits_on_state_id", using: :btree
  end

  create_table "admin_pricing_woods", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "admin_furniture_wood_type_id"
    t.integer  "price"
    t.text     "comment",                      limit: 65535
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.index ["admin_furniture_wood_type_id"], name: "index_admin_pricing_woods_on_admin_furniture_wood_type_id", using: :btree
  end

  create_table "admin_selling_config_days_to_completes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "extra"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_selling_config_piece_prices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "admin_furniture_set_id"
    t.integer  "admin_furniture_piece_id"
    t.float    "percentage",               limit: 24
    t.text     "comment",                  limit: 65535
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["admin_furniture_piece_id"], name: "index_selling_config_piece_prices_piece", using: :btree
    t.index ["admin_furniture_set_id"], name: "index_selling_config_piece_prices_set", using: :btree
  end

  create_table "admin_selling_config_prices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "admin_furniture_furniture_id"
    t.integer  "admin_furniture_fabric_brand_id"
    t.integer  "admin_furniture_paint_color_brand_id"
    t.integer  "admin_furniture_wood_type_id"
    t.float    "overall_cost",                         limit: 24
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "admin_furniture_set_id"
    t.index ["admin_furniture_fabric_brand_id"], name: "index_config_price_fabric", using: :btree
    t.index ["admin_furniture_furniture_id"], name: "index_config_price_furniture", using: :btree
    t.index ["admin_furniture_paint_color_brand_id"], name: "index_config_price_paint_color", using: :btree
    t.index ["admin_furniture_set_id"], name: "index_admin_selling_config_prices_on_admin_furniture_set_id", using: :btree
    t.index ["admin_furniture_wood_type_id"], name: "index_config_price_wood", using: :btree
  end

  create_table "admin_selling_config_profits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float    "overall",        limit: 24
    t.boolean  "overall_fixed"
    t.float    "marketer",       limit: 24
    t.boolean  "marketer_fixed"
    t.float    "marketed",       limit: 24
    t.boolean  "marketed_fixed"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "admin_sms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "message",    limit: 65535
    t.text     "to",         limit: 65535
    t.boolean  "is_urgent",                default: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "admin_uploaded_files", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.json     "images"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "owned",      default: false
    t.index ["owned"], name: "index_admin_uploaded_files_on_owned", using: :btree
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

  create_table "admin_workshop_workshops", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "state_id"
    t.text     "address",      limit: 65535
    t.integer  "user_id"
    t.string   "phone_number"
    t.text     "comment",      limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.datetime "ceased_at"
    t.index ["state_id"], name: "index_admin_workshop_workshops_on_state_id", using: :btree
    t.index ["user_id"], name: "index_admin_workshop_workshops_on_user_id", using: :btree
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

  create_table "employee_fanis", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "furniture_id"
    t.integer  "user_id"
    t.float    "wage_rokob",       limit: 24
    t.float    "wage_khayat",      limit: 24
    t.integer  "confirmed",        limit: 1,  default: 0
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.boolean  "needs_kande",                 default: false
    t.boolean  "needs_kalaf",                 default: false
    t.boolean  "needs_rang",                  default: false
    t.integer  "days_to_complete",            default: 0
    t.index ["furniture_id"], name: "index_employee_fanis_on_furniture_id", using: :btree
    t.index ["user_id"], name: "index_employee_fanis_on_user_id", using: :btree
  end

  create_table "employee_fanis_furniture_build_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "employee_fani_id"
    t.integer  "furniture_build_detail_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["employee_fani_id"], name: "index_employee_fani", using: :btree
    t.index ["furniture_build_detail_id"], name: "index_furniture_build_detail", using: :btree
  end

  create_table "employee_kalafs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "furniture_id"
    t.integer  "user_id"
    t.float    "wage",             limit: 24
    t.float    "choob",            limit: 24
    t.integer  "days_to_complete"
    t.integer  "confirmed",        limit: 1
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["furniture_id"], name: "index_employee_kalafs_on_furniture_id", using: :btree
    t.index ["user_id"], name: "index_employee_kalafs_on_user_id", using: :btree
  end

  create_table "employee_nagashes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "furniture_id"
    t.integer  "user_id"
    t.float    "wage",             limit: 24
    t.float    "astare_avaliye",   limit: 24
    t.float    "astare_asli",      limit: 24
    t.float    "range_asli",       limit: 24
    t.float    "rouye",            limit: 24
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "days_to_complete"
    t.integer  "confirmed",        limit: 1,  default: 0
    t.index ["furniture_id"], name: "index_employee_nagashes_on_furniture_id", using: :btree
    t.index ["user_id"], name: "index_employee_nagashes_on_user_id", using: :btree
  end

  create_table "employee_najars", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "furniture_id"
    t.integer  "user_id"
    t.float    "wage",             limit: 24
    t.float    "choob",            limit: 24
    t.integer  "days_to_complete"
    t.integer  "confirmed",        limit: 1,  default: 0
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["furniture_id"], name: "index_employee_najars_on_furniture_id", using: :btree
    t.index ["user_id"], name: "index_employee_najars_on_user_id", using: :btree
  end

  create_table "employee_overalls", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "admin_furniture_furniture_id"
    t.float    "fani_wage_rokob",              limit: 24
    t.json     "fani_build_details"
    t.float    "fani_wage_khayat",             limit: 24
    t.boolean  "fani_needs_kande"
    t.boolean  "fani_needs_kalaf"
    t.boolean  "fani_needs_rang"
    t.integer  "fani_days_to_complete"
    t.float    "nagash_wage",                  limit: 24
    t.float    "nagash_astare_avaliye",        limit: 24
    t.float    "nagash_astare_asli",           limit: 24
    t.float    "nagash_range_asli",            limit: 24
    t.float    "nagash_rouye",                 limit: 24
    t.integer  "nagash_days_to_complete"
    t.float    "najar_wage",                   limit: 24
    t.float    "najar_choob",                  limit: 24
    t.integer  "najar_days_to_complete"
    t.float    "kalaf_wage",                   limit: 24
    t.float    "kalaf_choob",                  limit: 24
    t.integer  "kalaf_days_to_complete"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["admin_furniture_furniture_id"], name: "index_employee_overalls_on_admin_furniture_furniture_id", using: :btree
  end

  create_table "employee_processeds", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "admin_furniture_id"
    t.integer  "user_id"
    t.string   "as_symbol"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["admin_furniture_id", "user_id", "as_symbol"], name: "index_unique_employee_processeds_all", unique: true, using: :btree
    t.index ["admin_furniture_id"], name: "index_employee_processeds_on_admin_furniture_id", using: :btree
    t.index ["as_symbol"], name: "index_employee_processeds_on_as_symbol", using: :btree
    t.index ["user_id"], name: "index_employee_processeds_on_user_id", using: :btree
  end

  create_table "furniture_build_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "admin_furniture_section_id"
    t.integer  "admin_furniture_spec_id"
    t.float    "value",                      limit: 24
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.json     "options"
    t.index ["admin_furniture_section_id"], name: "index_furniture_build_details_on_admin_furniture_section_id", using: :btree
    t.index ["admin_furniture_spec_id"], name: "index_furniture_build_details_on_admin_furniture_spec_id", using: :btree
  end

  create_table "notify_on_furniture_availables", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "admin_furniture_id"
    t.string   "phone_number"
    t.integer  "status",             limit: 1, default: 0
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["admin_furniture_id"], name: "index_notify_admin_furniture", using: :btree
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

  create_table "sessions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "session_id",                         null: false
    t.text     "data",                 limit: 65535
    t.datetime "verified_at"
    t.string   "verification_token"
    t.datetime "verification_send_at"
    t.datetime "last_accessed_at"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
    t.index ["updated_at"], name: "index_sessions_on_updated_at", using: :btree
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

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                            default: "",    null: false
    t.string   "encrypted_password",               default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",                  default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.datetime "deleted_at"
    t.integer  "admin_user_type_id",               default: 2
    t.datetime "blocked_at"
    t.string   "phone_number",                     default: "",    null: false
    t.integer  "creator_user_id"
    t.boolean  "change_password",                  default: false
    t.boolean  "is_added_to_phonebook",            default: false
    t.boolean  "error_on_add_to_phonebook",        default: false
    t.string   "two_step_auth_token"
    t.datetime "two_step_auth_token_sent_at"
    t.datetime "two_step_auth_token_confirmed_at"
    t.index ["admin_user_type_id"], name: "index_users_on_admin_user_type_id", using: :btree
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["creator_user_id"], name: "index_users_on_creator_user_id", using: :btree
    t.index ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  end

  add_foreign_key "admin_furniture_fabric_color_indices", "admin_furniture_fabric_colors"
  add_foreign_key "admin_furniture_fabric_color_indices", "admin_furniture_fabric_fabrics", column: "admin_furniture_fabric_id"
  add_foreign_key "admin_furniture_fabric_fabrics", "admin_furniture_fabric_brands"
  add_foreign_key "admin_furniture_fabric_fabrics", "admin_furniture_fabric_types"
  add_foreign_key "admin_furniture_fabric_models", "admin_furniture_fabric_fabrics"
  add_foreign_key "admin_furniture_furnitures", "admin_furniture_types", column: "furniture_type_id"
  add_foreign_key "admin_furniture_paint_colors", "admin_furniture_paint_color_brands", column: "admin_furniture_paint_color_brands_id"
  add_foreign_key "admin_furniture_paint_colors", "admin_furniture_paint_color_qualities", column: "admin_furniture_paint_color_qualities_id"
  add_foreign_key "admin_pricing_fabrics", "admin_furniture_fabric_brands"
  add_foreign_key "admin_pricing_foams", "admin_furniture_foam_types"
  add_foreign_key "admin_pricing_paint_colors", "admin_furniture_paint_color_brands"
  add_foreign_key "admin_pricing_transits", "admin_workshop_workshops"
  add_foreign_key "admin_pricing_transits", "states"
  add_foreign_key "admin_pricing_woods", "admin_furniture_wood_types"
  add_foreign_key "admin_selling_config_piece_prices", "admin_furniture_pieces"
  add_foreign_key "admin_selling_config_piece_prices", "admin_furniture_sets"
  add_foreign_key "admin_selling_config_prices", "admin_furniture_fabric_brands"
  add_foreign_key "admin_selling_config_prices", "admin_furniture_furnitures"
  add_foreign_key "admin_selling_config_prices", "admin_furniture_paint_color_brands"
  add_foreign_key "admin_selling_config_prices", "admin_furniture_sets"
  add_foreign_key "admin_selling_config_prices", "admin_furniture_wood_types"
  add_foreign_key "admin_workshop_workshops", "states"
  add_foreign_key "admin_workshop_workshops", "users"
  add_foreign_key "employee_fanis_furniture_build_details", "employee_fanis", on_update: :cascade, on_delete: :cascade
  add_foreign_key "employee_fanis_furniture_build_details", "furniture_build_details", on_update: :cascade, on_delete: :cascade
  add_foreign_key "employee_overalls", "admin_furniture_furnitures"
  add_foreign_key "employee_processeds", "admin_furniture_furnitures", column: "admin_furniture_id"
  add_foreign_key "employee_processeds", "users"
  add_foreign_key "furniture_build_details", "admin_furniture_sections"
  add_foreign_key "furniture_build_details", "admin_furniture_specs"
  add_foreign_key "notify_on_furniture_availables", "admin_furniture_furnitures", column: "admin_furniture_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "profiles", "states"
  add_foreign_key "profiles", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "shopping_carts", "admin_furniture_furnitures", column: "furniture_id"
  add_foreign_key "shopping_carts", "users"
  add_foreign_key "users", "admin_user_types"
end
