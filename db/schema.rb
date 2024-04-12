# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_04_12_175557) do
  create_table "comments", force: :cascade do |t|
    t.text "body", null: false
    t.integer "feature_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_id"], name: "index_comments_on_feature_id"
  end

  create_table "features", force: :cascade do |t|
    t.string "feature_type"
    t.decimal "mag"
    t.string "place", null: false
    t.integer "time", null: false
    t.string "url", null: false
    t.integer "tsunami"
    t.string "mag_type", null: false
    t.string "title", null: false
    t.decimal "latitude"
    t.decimal "longitude"
    t.string "record_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_id"], name: "index_features_on_record_id", unique: true
    t.check_constraint "latitude >= -90.0 AND mag <= 90.0", name: "latitude_check"
    t.check_constraint "longitude >= -180.0 AND mag <= 180.0", name: "longitude_check"
    t.check_constraint "mag >= -1.0 AND mag <= 10.0", name: "mag_check"
  end

  add_foreign_key "comments", "features"
end
