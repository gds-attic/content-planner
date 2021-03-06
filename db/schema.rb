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

ActiveRecord::Schema.define(version: 20140806142736) do

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "commentable_id",   null: false
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "commentable_type", null: false
    t.integer  "parent_id"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["parent_id"], name: "index_comments_on_parent_id", using: :btree

  create_table "content_needs", force: true do |t|
    t.integer "content_id"
    t.integer "need_api_id"
    t.integer "need_id"
  end

  add_index "content_needs", ["content_id", "need_api_id"], name: "index_content_needs_on_content_id_and_need_api_id", using: :btree

  create_table "content_plan_contents", force: true do |t|
    t.integer  "content_plan_id"
    t.integer  "content_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "content_plan_needs", force: true do |t|
    t.integer "content_plan_id"
    t.integer "need_api_id"
    t.integer "need_id"
  end

  add_index "content_plan_needs", ["content_plan_id", "need_api_id"], name: "index_content_plan_needs_on_content_plan_id_and_need_api_id", using: :btree

  create_table "content_plan_users", force: true do |t|
    t.integer "content_plan_id", null: false
    t.integer "user_id",         null: false
  end

  add_index "content_plan_users", ["content_plan_id", "user_id"], name: "index_content_plan_users_on_content_plan_id_and_user_id", using: :btree

  create_table "content_plans", force: true do |t|
    t.string   "ref_no"
    t.string   "title"
    t.text     "details"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "due_quarter"
    t.integer  "due_year"
  end

  create_table "content_users", force: true do |t|
    t.integer "content_id"
    t.integer "user_id"
  end

  add_index "content_users", ["content_id", "user_id"], name: "index_content_users_on_content_id_and_user_id", using: :btree

  create_table "contents", force: true do |t|
    t.text     "url"
    t.string   "content_type"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "platform"
    t.integer  "size"
    t.string   "title",        null: false
    t.text     "description"
    t.string   "ref_no"
    t.date     "publish_by"
  end

  create_table "needs", force: true do |t|
    t.integer "api_id"
    t.string  "role"
    t.string  "goal"
    t.string  "benefit"
    t.boolean "applies_to_all_organisations", default: false
    t.string  "in_scope"
  end

  create_table "organisation_needs", force: true do |t|
    t.integer  "organisation_id"
    t.integer  "need_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organisation_needs", ["need_id"], name: "index_organisation_needs_on_need_id", using: :btree
  add_index "organisation_needs", ["organisation_id"], name: "index_organisation_needs_on_organisation_id", using: :btree

  create_table "organisationables", force: true do |t|
    t.string   "organisation_id"
    t.integer  "organisationable_id"
    t.string   "organisationable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organisationables", ["organisation_id"], name: "index_organisationables_on_organisation_id", using: :btree
  add_index "organisationables", ["organisationable_id", "organisationable_type"], name: "organisationables", using: :btree
  add_index "organisationables", ["organisationable_type", "organisation_id"], name: "organisationable_type", using: :btree
  add_index "organisationables", ["organisationable_type"], name: "index_organisationables_on_organisationable_type", using: :btree

  create_table "organisations", force: true do |t|
    t.string   "title"
    t.string   "format"
    t.string   "slug"
    t.string   "abbreviation"
    t.string   "govuk_status"
    t.string   "parent_organisation"
    t.string   "ancestry"
    t.string   "web_url"
    t.string   "logo_formatted_name"
    t.string   "organisation_brand_colour_class_name"
    t.string   "organisation_logo_type_class_name"
    t.datetime "api_updated_at"
    t.datetime "api_closed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "api_id"
  end

  add_index "organisations", ["ancestry"], name: "index_organisations_on_ancestry", using: :btree
  add_index "organisations", ["slug"], name: "index_organisations_on_slug", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string "name"
  end

  create_table "task_and_users", force: true do |t|
    t.integer  "task_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "task_and_users", ["task_id"], name: "index_task_and_users_on_task_id", using: :btree
  add_index "task_and_users", ["user_id"], name: "index_task_and_users_on_user_id", using: :btree

  create_table "tasks", force: true do |t|
    t.string   "title"
    t.boolean  "done"
    t.integer  "taskable_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "taskable_type",   null: false
    t.datetime "deadline"
    t.integer  "creator_id"
    t.integer  "completed_by_id"
    t.datetime "done_at"
  end

  add_index "tasks", ["completed_by_id"], name: "index_tasks_on_completed_by_id", using: :btree
  add_index "tasks", ["creator_id"], name: "index_tasks_on_creator_id", using: :btree
  add_index "tasks", ["done"], name: "index_tasks_on_done", using: :btree
  add_index "tasks", ["done_at"], name: "index_tasks_on_done_at", using: :btree
  add_index "tasks", ["taskable_id", "taskable_type"], name: "index_tasks_on_taskable_id_and_taskable_type", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",               default: "",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "uid"
    t.string   "organisation_slug"
    t.string   "permissions"
    t.boolean  "remotely_signed_out", default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["organisation_slug"], name: "index_users_on_organisation_slug", using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
    t.string   "user_name"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
