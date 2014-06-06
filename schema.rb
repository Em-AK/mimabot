require "active_record"

ActiveRecord::Base.establish_connection(
  :adapter  => :sqlite3,
  :database => 'development.sqlite3'
)

ActiveRecord::Schema.define do
  create_table :fragments do |t|
    t.column :content, :text
    t.column :timestamp, :datetime
    t.column :tags, :string
    t.column :sender, :string
  end
 
end

