class RocketCmsCreateSeos < ActiveRecord::Migration[5.0]
  def change
    create_table :seos do |t|
      t.boolean :enabled, default: true, null: false
      t.integer :seoable_id
      t.string  :seoable_type
      RocketCMS::Migration.seo_fields(t)
      t.timestamps
    end

    add_index :seos, [:seoable_id, :seoable_type], unique: true
  end
end

