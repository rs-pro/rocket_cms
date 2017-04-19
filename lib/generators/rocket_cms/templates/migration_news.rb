class RocketCmsCreateNews < ActiveRecord::Migration[5.0]
  def change
    create_table :news do |t|
      t.boolean :enabled, default: true, null: false
      t.timestamp :time, null: false

      if RocketCMS.config.localize
        t.column :name_translations, 'hstore', default: {}
        t.column :excerpt_translations, 'hstore', default: {}
        t.column :content_translations, 'hstore', default: {}
      else
        t.string :name, null: false
        t.text :excerpt
        t.text :content
      end

      t.string :slug, null: false
      t.attachment :image
      t.timestamps
    end

    add_index :news, :slug, unique: true
    add_index :news, [:enabled, :time]
  end
end

