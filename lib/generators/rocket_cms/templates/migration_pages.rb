class RocketCmsCreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :menus do |t|

      if RocketCMS.config.localize
        t.column :name_translations, 'hstore'
      else
        t.string :name, null: false
      end
      t.string :slug, null: false
      t.timestamps
    end
    add_index :menus, :slug, unique: true

    create_table :pages do |t|
      t.boolean :enabled, default: true, null: false
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth

      if RocketCMS.config.localize
        t.column :name_translations, 'hstore', default: {}
        t.column :content_translations, 'hstore', default: {}
      else
        t.string :name, null: false
        t.text :content
      end

      t.string :slug, null: false
      t.string :regexp
      t.string :redirect
      t.string :fullpath, null: false
      t.timestamps
    end
    add_index :pages, :slug, unique: true
    add_index :pages, [:enabled, :lft]

    create_join_table :menus, :pages

    add_foreign_key(:menus_pages, :menus, on_delete: :cascade)
    add_foreign_key(:menus_pages, :pages, on_delete: :cascade)
  end
end

