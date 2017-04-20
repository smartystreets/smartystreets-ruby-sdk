require_relative 'alternate_county'

module USZipcode
  # See "https://smartystreets.com/docs/cloud/us-zipcode-api#zipcodes"
  class ZipCode
    attr_reader :longitude, :county_name, :zipcode, :zipcode_type, :county_fips,
                :latitude, :precision, :default_city, :alternate_counties,
                :state_abbreviation, :state

    def initialize(obj)
      @zipcode = obj['zipcode']
      @zipcode_type = obj['zipcode_type']
      @default_city = obj['default_city']
      @county_fips = obj['county_fips']
      @county_name = obj['county_name']
      @latitude = obj['latitude']
      @longitude = obj['longitude']
      @precision = obj['precision']
      @state = obj['state']
      @state_abbreviation = obj['state_abbreviation']
      alternate_counties = obj.fetch('alternate_counties', [])

      @alternate_counties = []

      alternate_counties.each do |county|
        @alternate_counties.push(USZipcode::AlternateCounty.new(county))
      end
    end
  end
end
