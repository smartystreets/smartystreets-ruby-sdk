module USStreet
  class Metadata
    attr_reader :elot_sort, :longitude, :elot_sequence, :county_fips, :building_default_indicator, :rdi,
                :congressional_district, :latitude, :precision, :time_zone, :zip_type, :county_name, :utc_offset,
                :record_type, :carrier_route, :obeys_dst

    def initialize(obj)
      @record_type = obj['record_type']
      @zip_type = obj['zip_type']
      @county_fips = obj['county_fips']
      @county_name = obj['county_name']
      @carrier_route = obj['carrier_route']
      @congressional_district = obj['congressional_district']
      @building_default_indicator = obj['building_default_indicator']
      @rdi = obj['rdi']
      @elot_sequence = obj['elot_sequence']
      @elot_sort = obj['elot_sort']
      @latitude = obj['latitude']
      @longitude = obj['longitude']
      @precision = obj['precision']
      @time_zone = obj['time_zone']
      @utc_offset = obj['utc_offset']
      @obeys_dst = obj['dst']
    end
  end
end