module RocketCMS
  module Migration
    extend self

    def seo_fields(t)
      if RocketCMS.config.localize
        t.column :h1_translations, 'hstore', default: {}
        t.column :title_translations, 'hstore', default: {}
        t.column :keywords_translations, 'hstore', default: {}
        t.column :description_translations, 'hstore', default: {}
        t.column :og_title_translations, 'hstore', default: {}
      else
        t.string :h1
        t.string :title
        t.text :keywords
        t.text :description
        t.string :og_title
      end
      t.string :robots
      t.attachment :og_image
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

