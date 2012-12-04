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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121202121106) do

  create_table "ads", :force => true do |t|
    t.string   "details"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "tags"
    t.string   "state",            :default => "active", :null => false
    t.string   "ad_type"
    t.integer  "user_id"
    t.boolean  "price_eval"
    t.boolean  "options_eval"
    t.integer  "brand_product_id"
  end

  add_index "ads", ["options_eval"], :name => "index_ads_on_options_eval"
  add_index "ads", ["price_eval"], :name => "index_ads_on_price_eval"
  add_index "ads", ["tags"], :name => "index_ads_on_tags"

  create_table "brand_products", :force => true do |t|
    t.integer  "brand_id"
    t.integer  "product_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "brands", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "company_id"
  end

  create_table "comments", :force => true do |t|
    t.integer  "indicative_price"
    t.string   "indicative_options"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.float    "price"
    t.text     "description"
    t.integer  "ad_id"
  end

  add_index "comments", ["price"], :name => "index_comments_on_price"

  create_table "companies", :force => true do |t|
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "company_type"
    t.boolean  "retailer"
    t.integer  "user_id"
    t.string   "company_name"
    t.boolean  "manufacturer"
  end

  create_table "companies_products", :force => true do |t|
    t.integer "company_id", :null => false
    t.integer "product_id", :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "industry"
    t.string   "category"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.text     "description"
    t.string   "product_type"
    t.string   "model"
  end

  create_table "rates", :force => true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.integer  "stars",         :null => false
    t.string   "dimension"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "rates", ["rateable_id", "rateable_type"], :name => "index_rates_on_rateable_id_and_rateable_type"
  add_index "rates", ["rater_id"], :name => "index_rates_on_rater_id"

  create_table "relationship_ads", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followedad_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "relationship_ads", ["followedad_id"], :name => "index_relationship_ads_on_followedad_id"
  add_index "relationship_ads", ["follower_id", "followedad_id"], :name => "index_relationship_ads_on_follower_id_and_followedad_id", :unique => true
  add_index "relationship_ads", ["follower_id"], :name => "index_relationship_ads_on_follower_id"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "reviews", :force => true do |t|
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
    t.integer  "rating"
    t.integer  "product_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                :default => "",           :null => false
    t.string   "encrypted_password",                   :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
    t.string   "display_name"
    t.string   "user_type",                            :default => "individual"
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.time     "confirmed_at"
    t.string   "confirmation_token"
    t.time     "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "zip_code"
    t.string   "city"
    t.string   "country"
    t.string   "street_address1"
    t.string   "street_address2"
    t.string   "state"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["display_name"], :name => "index_users_on_display_name", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token"
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
