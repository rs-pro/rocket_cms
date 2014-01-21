module SortField
  extend ActiveSupport::Concern

  module ClassMethods
    def sort_field(prefix = '')
      prefix = "#{prefix}_" unless prefix == ''

      field "#{prefix}sort".to_sym, type: Integer
      scope "#{prefix}sorted".to_sym, -> { asc("#{prefix}sort".to_sym) }
    end
  end
end
