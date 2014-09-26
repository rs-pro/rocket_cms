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
  end
end
