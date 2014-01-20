require 'stringex'
require 'digest/md5'

class String
  def filename_to_slug
    s = self.to_url
    if s.blank?
      return Digest::MD5.hexdigest(self)
    end
    s
  end
end

module FilenameToSlug
  extend ActiveSupport::Concern
  included do
    before_post_process :filename_to_slug
  end

  def filename_to_slug
    if self.class.attachment_definitions
      self.class.attachment_definitions.each do |k,v|
        if self.send(k).file?
          full_file_name = self.send("#{k}_file_name")
          extension = File.extname(full_file_name)[1..-1]
          file_name = full_file_name[0..full_file_name.size-extension.size-1]
          self.send("#{k}").instance_write(:file_name, "#{file_name.filename_to_slug}.#{extension.filename_to_slug}")
        end
      end
    end
  end
end
