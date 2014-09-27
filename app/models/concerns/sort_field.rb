module SortField
  extend ActiveSupport::Concern

  module ClassMethods
    def sort_field(prefix = '')
      prefix = "#{prefix}_" unless prefix == ''

      if RocketCMS.mongoid?
        field "#{prefix}sort".to_sym, type: Integer
        scope "#{prefix}sorted".to_sym, -> { asc("#{prefix}sort".to_sym) }
      end
      if RocketCMS.active_record?
        scope "#{prefix}sorted".to_sym, -> { order("#{prefix}sort".to_sym => :asc) }
      end
    end
  end
end
