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

ActiveRecord::Schema.define(:version => 20121212073150573) do

# Could not dump table "ads" because of following StandardError
#   Unknown type 'money' for column 'price'

  create_table "avatars", :force => true do |t|
    t.integer  "user_id"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.boolean  "active",            :default => true
  end

  add_index "avatars", ["user_id"], :name => "index_avatars_on_user_id"

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
    t.text     "description"
    t.integer  "ad_id"
    t.integer  "indicative_price_cents",    :default => 0,     :null => false
    t.string   "indicative_price_currency", :default => "USD", :null => false
    t.string   "indicative_options"
    t.boolean  "match_price"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "currency"
  end

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
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.text     "description"
    t.string   "product_type"
    t.string   "model"
    t.text     "modeldescription"
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
  add_index "rates", ["rater_id", "rateable_id"], :name => "index_rates_on_rater_id_and_rateable_id", :unique => true

  create_table "rating_caches", :force => true do |t|
    t.integer  "cacheable_id"
    t.string   "cacheable_type"
    t.float    "avg",            :null => false
    t.integer  "qty",            :null => false
    t.string   "dimension"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], :name => "index_rating_caches_on_cacheable_id_and_cacheable_type"

  create_table "relationship_ads", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followedad_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "relationship_ads", ["followedad_id"], :name => "index_relationship_ads_on_followedad_id"
  add_index "relationship_ads", ["follower_id", "followedad_id"], :name => "index_relationship_ads_on_follower_id_and_followedad_id", :unique => true
  add_index "relationship_ads", ["follower_id"], :name => "index_relationship_ads_on_follower_id"

  create_table "relationship_products", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followedproduct_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "relationship_products", ["followedproduct_id"], :name => "index_relationship_products_on_followedproduct_id"
  add_index "relationship_products", ["follower_id", "followedproduct_id"], :name => "index_relationshipproducts_follower_followedprodict_id", :unique => true
  add_index "relationship_products", ["follower_id"], :name => "index_relationship_products_on_follower_id"

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
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.text     "description"
    t.integer  "user_id"
    t.integer  "brand_product_id"
  end

  add_index "reviews", ["user_id", "brand_product_id"], :name => "index_reviews_on_user_id_and_brand_product_id"

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
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["display_name"], :name => "index_users_on_display_name", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token"
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
