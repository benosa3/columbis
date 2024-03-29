class CurrentSchema < ActiveRecord::Migration
  def up
    unless table_exists?("addresses")
      create_table "addresses" do |t|
        t.integer  "addressable_id"
        t.string   "addressable_type"
        t.string   "region"
        t.integer  "zip_code"
        t.string   "house_number"
        t.string   "housing"
        t.string   "office_number"
        t.string   "street"
        t.string   "phone_number"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.integer  "company_id"
        t.boolean  "delta",            :default => true
        t.text     "joint_address"
      end

      add_index "addresses", ["joint_address"], :name => "index_addresses_on_joint_address"
    end

    unless table_exists?("catalogs")
      create_table "catalogs" do |t|
        t.string   "name"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.integer  "company_id"
      end
    end

    unless table_exists?("cities")
      create_table "cities" do |t|
        t.integer "country_id"
        t.string  "name"
        t.integer "region_id"
        t.integer "company_id"
        t.boolean "common",     :default => false
      end

      add_index "cities", ["common"], :name => "index_cities_on_common"
      add_index "cities", ["company_id"], :name => "index_cities_on_company_id"
      add_index "cities", ["country_id", "region_id", "name"], :name => "index_cities_on_country_id_and_region_id_and_name"
      add_index "cities", ["name"], :name => "index_cities_on_name"
    end

    unless table_exists?("city_companies")
      create_table "city_companies" do |t|
        t.integer "city_id"
        t.integer "company_id"
      end
    end

    unless table_exists?("claims")
      create_table "claims" do |t|
        t.integer  "user_id"
        t.date     "check_date"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.integer  "office_id"
        t.integer  "operator_id"
        t.string   "operator_confirmation"
        t.string   "visa",                                                               :default => "nothing_done", :null => false
        t.string   "airport_to"
        t.string   "airport_back"
        t.string   "flight_to"
        t.string   "flight_back"
        t.date     "visa_check"
        t.float    "tour_price",                                                         :default => 0.0
        t.float    "visa_price",                                                         :default => 0.0
        t.float    "insurance_price",                                                    :default => 0.0
        t.float    "additional_insurance_price",                                         :default => 0.0
        t.float    "fuel_tax_price",                                                     :default => 0.0
        t.float    "primary_currency_price",                                             :default => 0.0
        t.float    "course_usd",                                                         :default => 0.0
        t.string   "tour_price_currency",                                                                            :null => false
        t.string   "airline"
        t.integer  "visa_count"
        t.string   "meals"
        t.string   "placement"
        t.integer  "nights"
        t.string   "hotel"
        t.date     "arrival_date"
        t.date     "departure_date"
        t.boolean  "early_reservation"
        t.text     "docs_note"
        t.date     "reservation_date"
        t.text     "memo"
        t.integer  "country_id"
        t.float    "operator_price",                                                     :default => 0.0,            :null => false
        t.float    "operator_debt",                                                      :default => 0.0,            :null => false
        t.float    "tourist_debt",                                                       :default => 0.0,            :null => false
        t.datetime "depart_to"
        t.datetime "depart_back"
        t.date     "maturity"
        t.boolean  "visa_confirmation_flag",                                             :default => false
        t.integer  "resort_id"
        t.integer  "city_id"
        t.string   "visa_price_currency",                                                :default => "eur",          :null => false
        t.string   "insurance_price_currency",                                           :default => "eur",          :null => false
        t.string   "additional_insurance_price_currency",                                :default => "eur",          :null => false
        t.string   "fuel_tax_price_currency",                                            :default => "eur",          :null => false
        t.text     "calculation"
        t.float    "course_eur",                                                         :default => 0.0
        t.float    "tourist_advance",                                                    :default => 0.0,            :null => false
        t.string   "tourist_paid"
        t.string   "operator_price_currency"
        t.boolean  "closed",                                                             :default => false
        t.boolean  "delta",                                                              :default => true
        t.float    "operator_advance",                                                   :default => 0.0,            :null => false
        t.string   "operator_paid"
        t.float    "profit",                                                             :default => 0.0,            :null => false
        t.float    "profit_in_percent",                                                  :default => 0.0,            :null => false
        t.string   "transfer"
        t.string   "relocation"
        t.string   "service_class"
        t.text     "additional_services"
        t.float    "additional_services_price",                                          :default => 0.0,            :null => false
        t.string   "additional_services_price_currency",                                 :default => "eur",          :null => false
        t.string   "medical_insurance"
        t.date     "operator_maturity"
        t.float    "approved_operator_advance",                                          :default => 0.0,            :null => false
        t.float    "approved_tourist_advance",                                           :default => 0.0,            :null => false
        t.boolean  "canceled",                                                           :default => false
        t.string   "documents_status",                                                   :default => "not_ready"
        t.boolean  "memo_tasks_done",                                                    :default => false
        t.boolean  "operator_confirmation_flag",                                         :default => false
        t.integer  "insurance_count"
        t.integer  "additional_insurance_count"
        t.integer  "fuel_tax_count"
        t.float    "children_visa_price",                                                :default => 0.0,            :null => false
        t.integer  "children_visa_count"
        t.string   "children_visa_price_currency",                                       :default => "eur",          :null => false
        t.string   "tourist_stat"
        t.float    "approved_operator_advance_prim",                                     :default => 0.0,            :null => false
        t.integer  "company_id"
        t.datetime "arrive_to"
        t.datetime "arrive_back"
        t.integer  "assistant_id"
        t.decimal  "bonus",                               :precision => 15, :scale => 2, :default => 0.0,            :null => false
        t.decimal  "bonus_percent",                       :precision => 5,  :scale => 2, :default => 0.0,            :null => false
        t.boolean  "active",                                                             :default => true,           :null => false
        t.boolean  "excluded_from_profit",                                               :default => false,          :null => false
      end
    end

    unless table_exists?("companies")
      create_table "companies" do |t|
        t.string   "email"
        t.string   "oficial_letter_signature"
        t.integer  "country_id"
        t.integer  "city_id"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.string   "name"
        t.string   "bank"
        t.string   "bik"
        t.string   "curr_account"
        t.string   "corr_account"
        t.string   "ogrn"
        t.string   "okpo"
        t.string   "site"
        t.string   "inn"
      end
    end

    unless table_exists?("countries")
      create_table "countries" do |t|
        t.string  "name"
        t.integer "company_id"
        t.boolean "common",     :default => false
      end

      add_index "countries", ["common"], :name => "index_countries_on_common"
      add_index "countries", ["company_id"], :name => "index_countries_on_company_id"
      add_index "countries", ["name"], :name => "index_countries_on_name"
    end

    unless table_exists?("currency_courses")
      create_table "currency_courses" do |t|
        t.integer  "user_id"
        t.datetime "on_date",                     :null => false
        t.string   "currency",                    :null => false
        t.float    "course",     :default => 0.0, :null => false
        t.datetime "created_at"
        t.datetime "updated_at"
        t.integer  "company_id"
      end

      add_index "currency_courses", ["currency", "on_date"], :name => "index_currency_courses_on_currency_and_on_date"
    end

    unless table_exists?("delayed_jobs")
      create_table "delayed_jobs" do |t|
        t.integer  "priority",   :default => 0
        t.integer  "attempts",   :default => 0
        t.text     "handler"
        t.text     "last_error"
        t.datetime "run_at"
        t.datetime "locked_at"
        t.datetime "failed_at"
        t.string   "locked_by"
        t.string   "queue"
        t.datetime "created_at",                :null => false
        t.datetime "updated_at",                :null => false
      end

      add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"
    end

    unless table_exists?("dropdown_values")
      create_table "dropdown_values" do |t|
        t.string  "list"
        t.string  "value"
        t.integer "company_id"
        t.boolean "common",     :default => false
        t.boolean "delta",      :default => true
      end

      add_index "dropdown_values", ["list"], :name => "index_dropdown_values_on_list"
      add_index "dropdown_values", ["value"], :name => "index_dropdown_values_on_value"
    end

    unless table_exists?("item_fields")
      create_table "item_fields" do |t|
        t.integer  "catalog_id"
        t.string   "name"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.integer  "company_id"
      end
    end

    unless table_exists?("items")
      create_table "items" do |t|
        t.datetime "created_at"
        t.datetime "updated_at"
        t.integer  "catalog_id"
        t.integer  "company_id"
      end
    end

    unless table_exists?("notes")
      create_table "notes" do |t|
        t.integer  "item_id"
        t.integer  "item_field_id"
        t.string   "value"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.integer  "company_id"
      end
    end

    unless table_exists?("offices")
      create_table "offices" do |t|
        t.string   "name"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.integer  "company_id"
        t.string   "default_password"
      end
    end

    unless table_exists?("operators")
      create_table "operators" do |t|
        t.string   "name"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.integer  "company_id"
        t.string   "register_number"
        t.string   "register_series"
        t.string   "inn"
        t.string   "ogrn"
        t.string   "site"
        t.string   "insurer"
        t.string   "insurer_address"
        t.string   "insurer_contract"
        t.date     "insurer_contract_date"
        t.date     "insurer_contract_start"
        t.date     "insurer_contract_end"
        t.string   "insurer_provision"
        t.boolean  "delta",                  :default => true
      end
    end

    unless table_exists?("payments")
      create_table "payments" do |t|
        t.integer  "claim_id"
        t.date     "date_in",                            :null => false
        t.integer  "payer_id",                           :null => false
        t.string   "payer_type",                         :null => false
        t.integer  "recipient_id",                       :null => false
        t.string   "recipient_type",                     :null => false
        t.string   "currency",                           :null => false
        t.float    "amount",          :default => 0.0
        t.string   "description"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.string   "form",                               :null => false
        t.float    "amount_prim",     :default => 0.0
        t.boolean  "approved",        :default => false
        t.float    "course",          :default => 1.0
        t.integer  "company_id"
        t.boolean  "reversed_course", :default => false
        t.boolean  "canceled",        :default => false
      end

      add_index "payments", ["approved"], :name => "index_payments_on_approved"
    end

    unless table_exists?("printers")
      create_table "printers" do |t|
        t.integer "company_id"
        t.integer "country_id"
        t.string  "template"
        t.string  "mode"
      end
    end

    unless table_exists?("regions")
      create_table "regions" do |t|
        t.integer "country_id"
        t.string  "name"
      end

      add_index "regions", ["country_id", "name"], :name => "index_regions_on_country_id_and_name"
      add_index "regions", ["name"], :name => "index_regions_on_name"
    end

    unless table_exists?("tasks")
      create_table "tasks" do |t|
        t.integer  "user_id"
        t.text     "body"
        t.string   "status"
        t.integer  "executer_id"
        t.datetime "start_date"
        t.datetime "end_date"
        t.boolean  "bug",         :default => false
        t.datetime "created_at",                     :null => false
        t.datetime "updated_at",                     :null => false
        t.boolean  "delta",       :default => true
        t.text     "comment"
      end
    end

    unless table_exists?("tourist_claims")
      create_table "tourist_claims" do |t|
        t.integer  "claim_id"
        t.integer  "tourist_id"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.boolean  "applicant",  :default => false
      end
    end

    unless table_exists?("tourists")
      create_table "tourists" do |t|
        t.string   "first_name"
        t.string   "last_name"
        t.string   "middle_name"
        t.integer  "passport_series"
        t.integer  "passport_number"
        t.date     "date_of_birth"
        t.date     "passport_valid_until"
        t.string   "phone_number"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.integer  "company_id"
        t.boolean  "delta",                :default => true
        t.boolean  "potential",            :default => false, :null => false
      end

      add_index "tourists", ["potential"], :name => "index_tourists_on_potential"
    end

    unless table_exists?("user_mailers")
      create_table "user_mailers" do |t|
        t.string   "title"
        t.text     "body"
        t.string   "parent_id"
        t.string   "message_id"
        t.integer  "task_id"
        t.datetime "created_at", :null => false
        t.datetime "updated_at", :null => false
      end
    end

    unless table_exists?("users")
      create_table "users" do |t|
        t.string   "email",                                 :default => "",   :null => false
        t.string   "encrypted_password",     :limit => 128, :default => "",   :null => false
        t.string   "reset_password_token"
        t.datetime "reset_password_sent_at"
        t.datetime "remember_created_at"
        t.integer  "sign_in_count",                         :default => 0
        t.datetime "current_sign_in_at"
        t.datetime "last_sign_in_at"
        t.string   "current_sign_in_ip"
        t.string   "last_sign_in_ip"
        t.string   "login"
        t.string   "last_name"
        t.string   "first_name"
        t.string   "middle_name"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.string   "role"
        t.integer  "office_id"
        t.string   "color"
        t.integer  "company_id"
        t.boolean  "delta",                                 :default => true
        t.string   "screen_width"
      end

      add_index "users", ["email"], :name => "index_users_on_email", :unique => true
      add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
    end
  end

  def down
  end
end
