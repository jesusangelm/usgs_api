require_relative '../config/environment'

class UsgsClient
  ALL_MONTH = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson'.freeze

  # Extract required data from API JSON response
  # return an Array of features
  # return nil if no features
  def extract_data
    features = request_data
    return unless features

    extracted_features = features.map do |f|
      next if f.dig('properties', 'title').blank?
      next if f.dig('properties', 'url').blank?
      next if f.dig('properties', 'place').blank?
      next if f.dig('properties', 'magType').blank?
      next unless f.dig('properties', 'mag') >= -1.0 && f.dig('properties', 'mag') <= 10.0
      next unless f.dig('geometry', 'coordinates', 1) >= -90.0 && f.dig('geometry', 'coordinates', 1) <= 90.0
      next unless f.dig('geometry', 'coordinates', 0) >= -180.0 && f.dig('geometry', 'coordinates', 0) <= 180.0

      {
        record_id: f['id'],
        mag: f.dig('properties', 'mag'),
        place: f.dig('properties', 'place'),
        time: f.dig('properties', 'time'),
        url: f.dig('properties', 'url'),
        tsunami: f.dig('properties', 'tsunami'),
        mag_type: f.dig('properties', 'magType'),
        title: f.dig('properties', 'title'),
        latitude: f.dig('geometry', 'coordinates', 1),
        longitude: f.dig('geometry', 'coordinates', 0)
      }
    end

    extracted_features.compact
  end

  private

  # Request JSON data from USGS API
  # return an Array of features if request success
  # return nil if request fail
  def request_data
    response = HTTParty.get(ALL_MONTH)
    response['features']
  rescue StandardError => e
    Rails.logger.error "[ERROR][USGS CLIENT] #{e}"
    raise e
  end
end
