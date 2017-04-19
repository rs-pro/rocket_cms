class RocketCmsCreateContactMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :contact_messages do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :content
      t.timestamps
    end

    add_index :contact_messages, :created_at
    add_index :contact_messages, :updated_at
  end
end

