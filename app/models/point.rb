class Point < ApplicationRecord
  attr_writer :latitude, :longitude
  belongs_to :resource, polymorphic: true
  before_save :update_coordinates

  def self.nearby(current_user, distance)
    where("ST_DWithin(points.coordinates, ST_GeographyFromText('SRID=4326;POINT(:longitude :latitude)'), :distance)",
          longitude: current_user.point.longitude,
          latitude: current_user.point.latitude,
          distance: distance)
  end

  def latitude
    @latitude || coordinates.latitude
  end

  def longitude
    @longitude || coordinates.longitude
  end

  protected

  def update_coordinates
    self.coordinates = "POINT(#{latitude} #{longitude})"
  end
end
