# frozen_string_literal: true

require_relative 'census_block_entry'
require_relative 'census_county_division_entry'
require_relative 'census_tract_entry'
require_relative 'core_based_stat_area_entry'
require_relative 'place_entry'

module SmartyStreets
  module USEnrichment
    module GeoReference
      class Attributes
        attr_reader :census_block, :census_county_division, :census_tract, :core_based_stat_area, :place

        def initialize(obj)
          @census_block = GeoReference::CensusBlockEntry.new(obj['census_block'])
          @census_county_division = GeoReference::CensusCountyDivisionEntry.new(obj['census_county_division'])
          @census_tract = GeoReference::CensusTractEntry.new(obj['census_tract'])
          @core_based_stat_area = GeoReference::CoreBasedStatAreaEntry.new(obj['core_based_stat_area'])
          @place = GeoReference::PlaceEntry.new(obj['place'])
        end
      end
    end
  end
end
