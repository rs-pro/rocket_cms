module Mappable
  extend ActiveSupport::Concern
  
  included do
    include Geocoder::Model::Mongoid
    
    field :coordinates, type: Array
    field :address, type: String
    
    field :map_address, type: String
    field :map_hint, type: String
    
    field :lat, type: Float
    field :lon, type: Float
    
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
    lat.blank? ? coordinates[1] : lat
  end
  def get_lon
    lon.blank? ? coordinates[0] : lon
  end
  
  def as_json(options = {})
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
