# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_09_05_075551) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_admins_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_admins_on_name"
    t.index ["resource_type", "resource_id"], name: "index_admins_on_resource_type_and_resource_id"
  end

  create_table "owners", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_owners_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_owners_on_name"
    t.index ["resource_type", "resource_id"], name: "index_owners_on_resource_type_and_resource_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string "headline"
    t.text "description"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "country"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.index ["latitude", "longitude"], name: "index_properties_on_latitude_and_longitude"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.string "icon_path"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_admins", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "admin_id"
    t.index ["admin_id"], name: "index_users_admins_on_admin_id"
    t.index ["user_id", "admin_id"], name: "index_users_admins_on_user_id_and_admin_id"
    t.index ["user_id"], name: "index_users_admins_on_user_id"
  end

  create_table "users_owners", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "owner_id"
    t.index ["owner_id"], name: "index_users_owners_on_owner_id"
    t.index ["user_id", "owner_id"], name: "index_users_owners_on_user_id_and_owner_id"
    t.index ["user_id"], name: "index_users_owners_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
