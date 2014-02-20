module Geocodeable
  extend ActiveSupport::Concern
  
  included do
    require 'geocoder'
    
    field :address, type: String
    field :map_hint, type: String
    field :map_address, type: String
    
    field :coordinates, type: Array
    include Geocoder::Model::Mongoid
    geocoded_by :geo_address

    after_validation do
      if new_record? || address_changed? || coordinates.nil? || map_address_changed?
        geocode
      end
    end

    field :lat, type: Float
    field :lon, type: Float
  end

  def geo_address
    if map_address.blank?
      address
    else
      map_address
    end
  end
  def get_lat
    lat.blank? ? coordinates[1] : lat
  end
  def get_lon
    lon.blank? ? coordinates[0] : lon
  end

  def has_map?
    (!lat.blank? && !lon.blank?) || !coordinates.nil?
  end

  def to_map
    {hint: map_hint, addr: address, lat: get_lat, lon: get_lon}
  end
  
  def self.geo_config
    Proc.new {
      active true
      label "Geo"
      field :address, :string
      field :map_address, :string
      field :coordinates do
        read_only true
      end
      field :lon
      field :lat
    }
  end
end
