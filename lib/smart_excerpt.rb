module SmartExcerpt
  class Helper
    include ActionView::Helpers::TextHelper

    def smart_truncate(s, opts = {})
      opts = {:words => 12}.merge(opts)
      if opts[:sentences]
        return s.split(/\.(\s|$)+/)[0, opts[:sentences]].map{|s| s.strip}.join('. ') + '.'
      end
      a = s.split(/\s/) # or /[ ]+/ to only split on spaces
      n = opts[:words]
      r = a[0...n].join(' ') + (a.size > n ? '...' : '')

      # replace &nbsp; with regular spaces
      r.gsub!(' ', ' ')

      # strip newlines
      r = r.strip.gsub("\r", '').gsub("\n", ' ')

      r.gsub(/\s+/, ' ')
    end
  end

  @@h = Helper.new
  @@he = HTMLEntities.new 

  def smart_truncate(obj, base_field, excerpt_field, words)
    if obj.send(excerpt_field).blank?
      tx = obj.send(base_field)
      if tx.blank?
        ''
      else
        tx = tx.gsub(/<h\d[^>]*?>(.*)<\/h\d>/mi, '').gsub("\n", ' ').gsub("\r", '').gsub("\t", '').strip
        tx = @@he.decode(tx)
        tx = @@h.strip_tags(tx)
        @@h.smart_truncate(tx, words: words)
      end
    else
      obj.send(excerpt_field)
    end
  end

  def self.included(base)
    base.send(:extend, ClassMethods)
    base.send(:include, InstanceMethods)
  end
  
  def self.decode(str)
    @@he.decode(str)
  end

  def self.encode(str)
    @@he.encode(str)
  end

  def self.strip_tags(str)
    @@h.strip_tags(str)
  end

  def self.decode_and_strip(str)
    self.strip_tags(self.decode(str))
  end

  def self.truncate(str, opts = {})
    tx = str.gsub(/<h\d[^>]*?>(.*)<\/h\d>/mi, '').gsub("\n", ' ').gsub("\r", '').gsub("\t", '').strip
    tx = @@he.decode(tx)
    tx = @@h.strip_tags(tx)
    @@h.smart_truncate(tx, opts)
  end

  module ClassMethods
    def smart_excerpt(excerpt_field, base_field, words = 25)
      define_method("get_#{excerpt_field}".to_sym) do
        smart_truncate(self, base_field, excerpt_field, words)
      end
    end
  end

  module InstanceMethods

  end
end
