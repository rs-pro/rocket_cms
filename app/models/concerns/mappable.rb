module Mappable
  extend ActiveSupport::Concern
  
  included do
    include Geocoder::Model::Mongoid
    
    if RocketCMS.mongoid?
      field :coordinates, type: Array
      field :address, type: String
      
      field :map_address, type: String
      field :map_hint, type: String
      
      field :lat, type: Float
      field :lon, type: Float
    end
    
    geocoded_by :geo_address
    
    after_validation do
      if geo_address.blank?
        self.coordinates = nil
      else
        if new_record? || address_changed? || coordinates.nil? || map_address_changed?
          geocode
        end
      end
    end
  end
  
  def get_lat
    if lat.blank? 
      if coordinates.nil?
        nil
      else
        coordinates[1]
      end
    else
      lat
    end
  end
  def get_lon
    if lon.blank? 
      if coordinates.nil?
        nil
      else
        coordinates[0]
      end
    else
      lon
    end
  end
  
  def has_map?
    (!lat.blank? && !lon.blank?) || !coordinates.nil?
  end
  
  def to_map
    {
      id: id.to_s,
      hint: map_hint,
      addr: address,
      lat: get_lat,
      lon: get_lon,
    }
  end
  
  def geo_address
    if map_address.blank?
      address
    else
      map_address
    end
  end
  
  def self.admin
    RocketCMS.map_config
  end
end
