require 'net/http'
require 'uri'

# Provide a method to query the Google Elevation API
module Elevation
  extend ActiveSupport::Concern
    
  # Get the elevation in meters from a location's latitude and longitude
  #
  # Returns a Float
  def elevation_for(latitude, longitude)
    base_url = 'http://maps.googleapis.com/maps/api/elevation/json'
    elevation_uri = URI.parse(
      "#{base_url}?locations=#{latitude},#{longitude}&sensor=false"
      )
    http = Net::HTTP.new(elevation_uri.host, elevation_uri.port)
    request = Net::HTTP::Get.new(elevation_uri.request_uri)
    response = http.request(request)
    if response.code == '200'
      response = JSON.parse(response.body)
      response['results'][0]['elevation'] if response['status'] == 'OK'
    end
  end
end