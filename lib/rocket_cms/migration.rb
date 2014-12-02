module RocketCMS
  module Migration
    extend self

    def seo_fields(t)
      t.string :name, null: false
      t.string :h1
      t.string :title
      t.text :keywords
      t.text :description
      t.string :robots
      t.string :og_title
      t.attachment :og_image

      #if RocketCMS.localize
        #t.column :name_translations, 'hstore'
        #t.column :name_translations, 'hstore'
      #end
    end

    def map_fields(t)
      t.text :address
      t.text :map_address
      t.text :map_hint
      t.float :latitude
      t.float :longitude
      t.float :lat
      t.float :lon
    end
  end
end
