class CreateSubmissions < ActiveRecord::Migration

  def self.up
    create_table :submissions do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.text :message
      t.boolean :spam
      t.string :your_interest
      t.string :how_did_you_find_us
      t.boolean :newsletter
      t.string :method_of_contact
      t.string :user_ip
      t.string :user_agent
      t.string :referrer
      t.integer :position

      t.timestamps
    end

    add_index :submissions, :id

    load(Rails.root.join('db', 'seeds', 'submissions.rb'))
  end

  def self.down
    if defined?(UserPlugin)
      UserPlugin.destroy_all({:name => "submissions"})
    end

    if defined?(Page)
      Page.delete_all({:link_url => "/submissions"})
    end

    drop_table :submissions
  end

end
