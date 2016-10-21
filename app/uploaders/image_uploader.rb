class ImageUploader < Shrine
  include ImageProcessing::MiniMagick

  plugin :activerecord
  plugin :determine_mime_type
  plugin :logging, logger: Rails.logger
  plugin :remove_attachment
  plugin :store_dimensions
  plugin :validation_helpers
  plugin :versions
  plugin :processing

  ALLOWED_MIME_TYPES = %w(image/jpg image/jpeg image/png image/gif)

  Attacher.validate do
    validate_max_size(2.megabytes, message: 'is too large (max is 2 MB)')
    validate_mime_type_inclusion(ALLOWED_MIME_TYPES)
  end

  process(:store) do |io, context|
    size_700 = resize_to_limit(io.download, 700, 700)
    size_500 = resize_to_limit(size_700,    500, 500)
    size_300 = resize_to_limit(size_500,    300, 300)

    { large: size_700, medium: size_500, small: size_300 }
  end
end
