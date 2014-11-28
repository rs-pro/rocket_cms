module RocketCMS
  module Migration
    extend self

    def seo_fields(t)
      t.string :name, null: false
      t.string :h1
      t.string :title
      t.string :keywords
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
      t.string :address
      t.string :map_address
      t.string :map_hint
      t.float :latitude
      t.float :longitude
    end
  end
end
