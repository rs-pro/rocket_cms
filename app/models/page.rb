class Page
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  include ActiveModel::ForbiddenAttributesProtection
  include Trackable
  include Seoable

  field :regexp, type: String
  field :redirect, type: String
  field :content, type: String
  field :fullpath, type: String

  field :enabled, type: Mongoid::Boolean, default: true
  scope :enabled, -> { where(enabled: true).order_by([:lft, :asc]) }
  scope :sorted, -> { order_by([:lft, :asc]) }
  scope :menu, ->(menu_id) { enabled.sorted.where(menu_ids: menu_id) }

  has_and_belongs_to_many :menus, inverse_of: :pages

  acts_as_nested_set

  include ManualSlug
  manual_slug :name

  include Enableable

  before_save do
    self.fullpath = "/pages/#{slug}" if self.fullpath.blank?
  end

  def get_fullpath
    redirect.blank? ? fullpath: redirect
  end

  validates_presence_of :name

  def has_content?
    @content_used.nil? && !content.blank?
  end

  def page_content
    if @content_used.nil?
      @content_used = true
      if content.nil?
        ''
      else
        content.gsub(/\{\{(.*?)\}\}/) do
          Settings.get($1).val
        end
      end
    else
      ''
    end
  end

  def is_current?(url)
    if fullpath == '/'
      url == '/'
    else
      url.match(clean_regexp)
    end
  end
  
  def clean_regexp
    if regexp.blank?
      /^#{Regexp.escape(fullpath)}$/
    else
      begin
        /#{regexp}/
      rescue
        # not a valid regexp - treat as literal search string
        /#{Regexp.escape(regexp)}/
      end
    end
  end

  rails_admin do
    navigation_label 'CMS'

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
    end

    edit do
      field :name
      field :content, :ckeditor

      group :menu do
        label "Меню"
        field :menus

        field :fullpath, :string do
          help "c начальным слешем"
        end
        field :regexp, :string do
          help "Регулярное выражение, по которому определяется является ли этот пункт активным"
        end
        field :redirect, :string do
          help "В меню сразу отдается конечная ссылка"
        end
      end

      group :seo, &Seoable.seo_config
    end

    nested_set({
        max_depth: 2
    })
  end
end
