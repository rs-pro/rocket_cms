if defined?(Shrine)
  class ImageUploader < Shrine
    # plugins and uploading logic
  end
else
  class ImageUploader
  end
end
