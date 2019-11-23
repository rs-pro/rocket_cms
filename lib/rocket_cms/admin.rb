module RocketCMS
  class << self
    def map_config(is_active = true)
      Proc.new {
        active is_active
        label I18n.t('rs.map')
        field :address, :string
        field :map_address, :string
        field :map_hint, :string
        field :coordinates, :string do
          read_only true
          formatted_value{ bindings[:object].coordinates.to_json }
        end
        field :lat
        field :lon
      }
    end

    def seo_config(is_active = true)
      Proc.new {
        if respond_to?(:active)
          active is_active
          label "SEO"
        else
          visible false
        end
        RocketCMS.seo_fields(self)
      }
    end

    def seo_fields(s)
      s.instance_eval do
        field :h1, :string
        field :title, :string
        field :keywords, :text
        field :description, :text
        field :robots, :string

        field :og_title, :string
        if RocketCMS.shrine?
          field :og_image, :paperclip
        elsif RocketCMS.paperclip?
          field :og_image, :paperclip
        end
      end
    end

    def page_config
      Proc.new {
        RocketCMS.apply_patches self
        navigation_label I18n.t('rs.cms')
        list do
          field :enabled,  :toggle
          field :menus, :menu
          field :name
          field :fullpath do
            pretty_value do
              bindings[:view].content_tag(:a, bindings[:object].fullpath, href: bindings[:object].fullpath)
            end
          end
          field :redirect
          field :slug
          RocketCMS.apply_patches self
        end
        edit do
          field :name
          field :content, :ckeditor
          RocketCMS.apply_patches self
          group :menu do
            label I18n.t('rs.menu')
            field :menus
            field :fullpath, :string do
              help I18n.t('rs.with_final_slash')
            end
            field :regexp, :string do
              help I18n.t('rs.page_url_regex')
            end
            field :redirect, :string do
              help I18n.t('rs.final_in_menu')
            end
            field :text_slug do
              read_only true
            end
          end
          if Seo.separate_table?
            group :seo do
              active RocketCMS.config.seo_active_by_default
              field :seo do
                active RocketCMS.config.seo_active_by_default
              end
            end
          else
            group :seo, &RocketCMS.seo_config(RocketCMS.config.seo_active_by_default)
          end
        end
        RocketCMS.only_patches self, [:show, :export]
        nested_set({
          max_depth: RocketCMS.config.menu_max_depth
        })
      }
    end

    def menu_config
      Proc.new {
          navigation_label 'CMS'
          field :text_slug
          field :name
          RocketCMS.apply_patches self
          RocketCMS.only_patches self, [:show, :list, :edit, :export]
      }
    end

    def contact_message_config
      Proc.new {
        navigation_label I18n.t('rs.settings')
        field :created_at do
          read_only true
        end
        field :name
        field :content
        field :email
        field :phone

        RocketCMS.apply_patches self
        RocketCMS.only_patches self, [:show, :list, :edit, :export]
      }
    end

    def news_config
      Proc.new {
        navigation_label I18n.t('rs.cms')

        field :enabled, :toggle
        field :time do
          sort_reverse true
        end
        field :name
        unless RocketCMS.config.news_image_styles.nil?
          field :image
        end
        field :excerpt
        RocketCMS.apply_patches self

        list do
          RocketCMS.apply_patches self
          sort_by :time
        end

        edit do
          field :content, :ckeditor
          RocketCMS.apply_patches self
          group :seo, &RocketCMS.seo_config
        end

        RocketCMS.only_patches self, [:show, :list, :export]
      }
    end
  end
end
