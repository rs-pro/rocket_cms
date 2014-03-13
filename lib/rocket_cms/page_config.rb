module RocketCMS
  def self.page_config
    Proc.new {
      RocketCMS.apply_patches self
      navigation_label I18n.t('rs.cms')
      list do
        field :enabled,  :toggle
        field :menus
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
        end
        group :seo, &Seoable.seo_config
      end
      RocketCMS.only_patches self, [:show, :export]
      nested_set({
        max_depth: RocketCMS.configuration.menu_max_depth
      })
    }
  end
end
