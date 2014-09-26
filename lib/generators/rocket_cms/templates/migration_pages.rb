class RocketCmsCreatePages < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :name
      t.string :slug
      t.timestamps
    end

    create_table :pages do |t|
      t.timestamp :time
      t.boolean :enabled, default: false
      t.string :slug
      t.attachment :image
      RocketCMS::Migration.seo_fields(t)
      t.timestamps
    end

    create_join_table :menus, :pages

    add_foreign_key(:menus_pages, :menus, dependent: :delete)
    add_foreign_key(:menus_pages, :pages, dependent: :delete)
  end
end

