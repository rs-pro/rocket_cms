class RocketCmsCreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.boolean :enabled, default: true
      t.timestamp :time
      t.string :name
      t.text :excerpt
      t.text :content

      t.string :slug
      t.attachment :image
      RocketCMS::Migration.seo_fields(t)

      t.timestamps
    end

    add_index :news, :slug
    add_index :news, [:enabled, :time]
  end
end

