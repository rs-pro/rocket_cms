class RocketCmsCreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.boolean :enabled, default: true, null: false
      t.timestamp :time, null: false
      t.string :name, null: false
      t.text :excerpt
      t.text :content

      t.string :slug, null: false
      t.attachment :image
      RocketCMS::Migration.seo_fields(t)

      t.timestamps
    end

    add_index :news, :slug, unique: true
    add_index :news, [:enabled, :time]
  end
end

