# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  storage :fog
  # fog_directory "criticube-#{Rails.env}-avatars"

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:

  def store_dir
    "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Process files as they are uploaded:
  process :resize_to_fill => [150, 150]
  process :convert => 'jpg'

  # Create different versions of your uploaded files:
  version :medium do
    process :resize_to_fill => [100, 100]
    process :convert => 'jpg'
  end

  version :thumb do
    process :resize_to_fill => [50, 50]
    process :convert => 'jpg'
  end

  version :small do
    process :resize_to_fill => [32, 32]
    process :convert => 'jpg'
  end
  
  version :inline do
    process :resize_to_fit => [20, 20]
    process :convert => 'jpg'
  end

  def extension_white_list
    %w(jpg jpeg png gif)
  end

  def filename
    "avatar.jpg" if original_filename
  end

  def default_url
    if version_name
      "fallback/" + [version_name, "avatar.jpg"].compact.join('_')
    else
      "fallback/avatar.jpg"
    end  
  end

end
