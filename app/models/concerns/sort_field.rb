module SortField
  extend ActiveSupport::Concern

  module ClassMethods
    def sort_field(prefix = '')
      prefix = "#{prefix}_" unless prefix == ''

      if RocketCMS.mongoid?
        field "#{prefix}sort".to_sym, type: Integer
      end
      scope "#{prefix}sorted".to_sym, -> { asc("#{prefix}sort".to_sym) }
    end
  end
end
