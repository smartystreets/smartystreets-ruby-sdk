class ZipCode
  def initialize(obj)
    @zipcode = obj['zipcode']
    @zipcode_type = obj['zipcode_type']
    @default_city = obj['default_city']
    @county_fips = obj['county_fips']
    @county_name = obj['county_name']
    @latitude = obj['latitude']
    @longitude = obj['longitude']
    @precision = obj['precision']
  end
end