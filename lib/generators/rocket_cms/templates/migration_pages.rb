class RocketCmsCreatePages < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.timestamps
    end
    add_index :menus, :slug, unique: true

    create_table :pages do |t|
      t.boolean :enabled, default: false
      t.string :slug, null: false
      t.attachment :image

      t.string :regexp
      t.string :redirect
      t.string :content
      t.string :fullpath, null: false
      RocketCMS::Migration.seo_fields(t)
      t.timestamps
    end
    add_index :pages, :slug, unique: true

    create_join_table :menus, :pages

    add_foreign_key(:menus_pages, :menus, dependent: :delete)
    add_foreign_key(:menus_pages, :pages, dependent: :delete)
  end
end

