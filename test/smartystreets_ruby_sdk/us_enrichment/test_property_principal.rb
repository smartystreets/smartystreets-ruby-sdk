# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../../lib/smartystreets_ruby_sdk/us_enrichment/property/principal/response'
require_relative '../../test_helper'
require 'smartystreets_ruby_sdk/us_enrichment/property/principal/attributes'

class TestPropertyFinancialResponse < Minitest::Test
  def test_all_fields_filled_correctly
    attributes_obj = {
      '1st_floor_sqft' => '1st_floor_sqft',
      '2nd_floor_sqft' => '2nd_floor_sqft',
      'acres' => 'acres',
      'air_conditioner' => 'air_conditioner',
      'arbor_pergola' => 'arbor_pergola',
      'assessed_improvement_percent' => 'assessed_improvement_percent',
      'assessed_improvement_value' => 'assessed_improvement_value',
      'assessed_land_value' => 'assessed_land_value',
      'assessed_value' => 'assessed_value',
      'assessor_last_update' => 'assessor_last_update',
      'assessor_taxroll_update' => 'assessor_taxroll_update',
      'attic_area' => 'attic_area',
      'attic_flag' => 'attic_flag',
      'balcony' => 'balcony',
      'balcony_area' => 'balcony_area',
      'basement_sqft' => 'basement_sqft',
      'basement_sqft_finished' => 'basement_sqft_finished',
      'basement_sqft_unfinished' => 'basement_sqft_unfinished',
      'bath_house' => 'bath_house',
      'bath_house_sqft' => 'bath_house_sqft',
      'bathrooms_partial' => 'bathrooms_partial',
      'bathrooms_total' => 'bathrooms_total',
      'bedrooms' => 'bedrooms',
      'block1' => 'block1',
      'block2' => 'block2',
      'boat_access' => 'boat_access',
      'boat_house' => 'boat_house',
      'boat_house_sqft' => 'boat_house_sqft',
      'boat_lift' => 'boat_lift',
      'bonus_room' => 'bonus_room',
      'breakfast_nook' => 'breakfast_nook',
      'breezeway' => 'breezeway',
      'building_definition_code' => 'building_definition_code',
      'building_sqft' => 'building_sqft',
      'cabin' => 'cabin',
      'cabin_sqft' => 'cabin_sqft',
      'canopy' => 'canopy',
      'canopy_sqft' => 'canopy_sqft',
      'carport' => 'carport',
      'carport_sqft' => 'carport_sqft',
      'cbsa_code' => 'cbsa_code',
      'cbsa_name' => 'cbsa_name',
      'cellar' => 'cellar',
      'census_block' => 'census_block',
      'census_block_group' => 'census_block_group',
      'census_fips_place_code' => 'census_fips_place_code',
      'census_tract' => 'census_tract',
      'central_vacuum' => 'central_vacuum',
      'code_title_company' => 'code_title_company',
      'combined_statistical_area' => 'combined_statistical_area',
      'community_rec' => 'community_rec',
      'company_flag' => 'company_flag',
      'congressional_district' => 'congressional_district',
      'construction_type' => 'construction_type',
      'contact_city' => 'contact_city',
      'contact_crrt' => 'contact_crrt',
      'contact_full_address' => 'contact_full_address',
      'contact_house_number' => 'contact_house_number',
      'contact_mail_info_format' => 'contact_mail_info_format',
      'contact_mail_info_privacy' => 'contact_mail_info_privacy',
      'contact_mailing_county' => 'contact_mailing_county',
      'contact_mailing_fips' => 'contact_mailing_fips',
      'contact_post_direction' => 'contact_post_direction',
      'contact_pre_direction' => 'contact_pre_direction',
      'contact_state' => 'contact_state',
      'contact_street_name' => 'contact_street_name',
      'contact_suffix' => 'contact_suffix',
      'contact_unit_designator' => 'contact_unit_designator',
      'contact_value' => 'contact_value',
      'contact_zip' => 'contact_zip',
      'contact_zip4' => 'contact_zip4',
      'courtyard' => 'courtyard',
      'courtyard_area' => 'courtyard_area',
      'deck' => 'deck',
      'deck_area' => 'deck_area',
      'deed_document_page' => 'deed_document_page',
      'deed_document_book' => 'deed_document_book',
      'deed_document_number' => 'deed_document_number',
      'deed_owner_first_name' => 'deed_owner_first_name',
      'deed_owner_first_name2' => 'deed_owner_first_name2',
      'deed_owner_first_name3' => 'deed_owner_first_name3',
      'deed_owner_first_name4' => 'deed_owner_first_name4',
      'deed_owner_full_name' => 'deed_owner_full_name',
      'deed_owner_full_name2' => 'deed_owner_full_name2',
      'deed_owner_full_name3' => 'deed_owner_full_name3',
      'deed_owner_full_name4' => 'deed_owner_full_name4',
      'deed_owner_last_name' => 'deed_owner_last_name',
      'deed_owner_last_name2' => 'deed_owner_last_name2',
      'deed_owner_last_name3' => 'deed_owner_last_name3',
      'deed_owner_last_name4' => 'deed_owner_last_name4',
      'deed_owner_middle_name' => 'deed_owner_middle_name',
      'deed_owner_middle_name2' => 'deed_owner_middle_name2',
      'deed_owner_middle_name3' => 'deed_owner_middle_name3',
      'deed_owner_middle_name4' => 'deed_owner_middle_name4',
      'deed_owner_suffix' => 'deed_owner_suffix',
      'deed_owner_suffix2' => 'deed_owner_suffix2',
      'deed_owner_suffix3' => 'deed_owner_suffix3',
      'deed_owner_suffix4' => 'deed_owner_suffix4',
      'deed_sale_date' => 'deed_sale_date',
      'deed_sale_price' => 'deed_sale_price',
      'deed_transaction_id' => 'deed_transaction_id',
      'depth_linear_footage' => 'depth_linear_footage',
      'disabled_tax_exemption' => 'disabled_tax_exemption',
      'driveway_sqft' => 'driveway_sqft',
      'driveway_type' => 'driveway_type',
      'effective_year_built' => 'effective_year_built',
      'elevation_feet' => 'elevation_feet',
      'elevator' => 'elevator',
      'equestrian_arena' => 'equestrian_arena',
      'escalator' => 'escalator',
      'exercise_room' => 'exercise_room',
      'exterior_walls' => 'exterior_walls',
      'family_room' => 'family_room',
      'fence' => 'fence',
      'fence_area' => 'fence_area',
      'fips_code' => 'fips_code',
      'fire_resistance_code' => 'fire_resistance_code',
      'fire_sprinklers_flag' => 'fire_sprinklers_flag',
      'fireplace' => 'fireplace',
      'fireplace_number' => 'fireplace_number',
      'first_name' => 'first_name',
      'first_name_2' => 'first_name_2',
      'first_name_3' => 'first_name_3',
      'first_name_4' => 'first_name_4',
      'flooring' => 'flooring',
      'foundation' => 'foundation',
      'game_room' => 'game_room',
      'garage' => 'garage',
      'garage_sqft' => 'garage_sqft',
      'gazebo' => 'gazebo',
      'gazebo_sqft' => 'gazebo_sqft',
      'golf_course' => 'golf_course',
      'grainery' => 'grainery',
      'grainery_sqft' => 'grainery_sqft',
      'great_room' => 'great_room',
      'greenhouse' => 'greenhouse',
      'greenhouse_sqft' => 'greenhouse_sqft',
      'gross_sqft' => 'gross_sqft',
      'guesthouse' => 'guesthouse',
      'guesthouse_sqft' => 'guesthouse_sqft',
      'handicap_accessibility' => 'handicap_accessibility',
      'heat' => 'heat',
      'heat_fuel_type' => 'heat_fuel_type',
      'hobby_room' => 'hobby_room',
      'homeowner_tax_exemption' => 'homeowner_tax_exemption',
      'instrument_date' => 'instrument_date',
      'intercom_system' => 'intercom_system',
      'interest_rate_type_2' => 'interest_rate_type_2',
      'interior_structure' => 'interior_structure',
      'kennel' => 'kennel',
      'kennel_sqft' => 'kennel_sqft',
      'land_use_code' => 'land_use_code',
      'land_use_group' => 'land_use_group',
      'land_use_standard' => 'land_use_standard',
      'last_name' => 'last_name',
      'last_name_2' => 'last_name_2',
      'last_name_3' => 'last_name_3',
      'last_name_4' => 'last_name_4',
      'latitude' => 'latitude',
      'laundry' => 'laundry',
      'lean_to' => 'lean_to',
      'lean_to_sqft' => 'lean_to_sqft',
      'legal_description' => 'legal_description',
      'legal_unit' => 'legal_unit',
      'lender_address' => 'lender_address',
      'lender_address_2' => 'lender_address_2',
      'lender_city' => 'lender_city',
      'lender_city_2' => 'lender_city_2',
      'lender_code_2' => 'lender_code_2',
      'lender_first_name' => 'lender_first_name',
      'lender_first_name_2' => 'lender_first_name_2',
      'lender_last_name' => 'lender_last_name',
      'lender_last_name_2' => 'lender_last_name_2',
      'lender_name' => 'lender_name',
      'lender_name_2' => 'lender_name_2',
      'lender_seller_carry_back' => 'lender_seller_carry_back',
      'lender_seller_carry_back_2' => 'lender_seller_carry_back_2',
      'lender_state' => 'lender_state',
      'lender_state_2' => 'lender_state_2',
      'lender_zip' => 'lender_zip',
      'lender_zip_2' => 'lender_zip_2',
      'lender_zip_extended' => 'lender_zip_extended',
      'lender_zip_extended_2' => 'lender_zip_extended_2',
      'loading_platform' => 'loading_platform',
      'loading_platform_sqft' => 'loading_platform_sqft',
      'longitude' => 'longitude',
      'lot_1' => 'lot_1',
      'lot_2' => 'lot_2',
      'lot_3' => 'lot_3',
      'lot_sqft' => 'lot_sqft',
      'market_improvement_percent' => 'market_improvement_percent',
      'market_improvement_value' => 'market_improvement_value',
      'market_land_value' => 'market_land_value',
      'market_value_year' => 'market_value_year',
      'match_type' => 'match_type',
      'media_room' => 'media_room',
      'metro_division' => 'metro_division',
      'middle_name' => 'middle_name',
      'middle_name_2' => 'middle_name_2',
      'middle_name_3' => 'middle_name_3',
      'middle_name_4' => 'middle_name_4',
      'milkhouse' => 'milkhouse',
      'milkhouse_sqft' => 'milkhouse_sqft',
      'minor_civil_division_code' => 'minor_civil_division_code',
      'minor_civil_division_name' => 'minor_civil_division_name',
      'mobile_home_hookup' => 'mobile_home_hookup',
      'mortgage_amount' => 'mortgage_amount',
      'mortgage_amount_2' => 'mortgage_amount_2',
      'mortgage_due_date' => 'mortgage_due_date',
      'mortgage_due_date_2' => 'mortgage_due_date_2',
      'mortgage_interest_rate' => 'mortgage_interest_rate',
      'mortgage_interest_rate_type' => 'mortgage_interest_rate_type',
      'mortgage_lender_code' => 'mortgage_lender_code',
      'mortgage_rate_2' => 'mortgage_rate_2',
      'mortgage_recording_date' => 'mortgage_recording_date',
      'mortgage_recording_date_2' => 'mortgage_recording_date_2',
      'mortgage_term' => 'mortgage_term',
      'mortgage_term_2' => 'mortgage_term_2',
      'mortgage_term_type' => 'mortgage_term_type',
      'mortgage_term_type_2' => 'mortgage_term_type_2',
      'mortgage_type' => 'mortgage_type',
      'mortgage_type_2' => 'mortgage_type_2',
      'msa_code' => 'msa_code',
      'msa_name' => 'msa_name',
      'mud_room' => 'mud_room',
      'multi_parcel_flag' => 'multi_parcel_flag',
      'name_title_company' => 'name_title_company',
      'neighborhood_code' => 'neighborhood_code',
      'number_of_buildings' => 'number_of_buildings',
      'office' => 'office',
      'office_sqft' => 'office_sqft',
      'other_tax_exemption' => 'other_tax_exemption',
      'outdoor_kitchen_fireplace' => 'outdoor_kitchen_fireplace',
      'overhead_door' => 'overhead_door',
      'owner_full_name' => 'owner_full_name',
      'owner_full_name_2' => 'owner_full_name_2',
      'owner_full_name_3' => 'owner_full_name_3',
      'owner_full_name_4' => 'owner_full_name_4',
      'owner_occupancy_status' => 'owner_occupancy_status',
      'ownership_transfer_date' => 'ownership_transfer_date',
      'ownership_transfer_doc_number' => 'ownership_transfer_doc_number',
      'ownership_transfer_transaction_id' => 'ownership_transfer_transaction_id',
      'ownership_type' => 'ownership_type',
      'ownership_type_2' => 'ownership_type_2',
      'ownership_vesting_relation_code' => 'ownership_vesting_relation_code',
      'parcel_account_number' => 'parcel_account_number',
      'parcel_map_book' => 'parcel_map_book',
      'parcel_map_page' => 'parcel_map_page',
      'parcel_number_alternate' => 'parcel_number_alternate',
      'parcel_number_formatted' => 'parcel_number_formatted',
      'parcel_number_previous' => 'parcel_number_previous',
      'parcel_number_year_added' => 'parcel_number_year_added',
      'parcel_number_year_change' => 'parcel_number_year_change',
      'parcel_raw_number' => 'parcel_raw_number',
      'parcel_shell_record' => 'parcel_shell_record',
      'parking_spaces' => 'parking_spaces',
      'patio_area' => 'patio_area',
      'phase_name' => 'phase_name',
      'plumbing_fixtures_count' => 'plumbing_fixtures_count',
      'pole_struct' => 'pole_struct',
      'pole_struct_sqft' => 'pole_struct_sqft',
      'pond' => 'pond',
      'pool' => 'pool',
      'pool_area' => 'pool_area',
      'poolhouse' => 'poolhouse',
      'poolhouse_sqft' => 'poolhouse_sqft',
      'porch' => 'porch',
      'porch_area' => 'porch_area',
      'poultry_house' => 'poultry_house',
      'poultry_house_sqft' => 'poultry_house_sqft',
      'previous_assessed_value' => 'previous_assessed_value',
      'prior_sale_amount' => 'prior_sale_amount',
      'prior_sale_date' => 'prior_sale_date',
      'property_address_carrier_route_code' => 'property_address_carrier_route_code',
      'property_address_city' => 'property_address_city',
      'property_address_full' => 'property_address_full',
      'property_address_house_number' => 'property_address_house_number',
      'property_address_post_direction' => 'property_address_post_direction',
      'property_address_pre_direction' => 'property_address_pre_direction',
      'property_address_state' => 'property_address_state',
      'property_address_street_name' => 'property_address_street_name',
      'property_address_street_suffix' => 'property_address_street_suffix',
      'property_address_unit_designator' => 'property_address_unit_designator',
      'property_address_unit_value' => 'property_address_unit_value',
      'property_address_zip_4' => 'property_address_zip_4',
      'property_address_zipcode' => 'property_address_zipcode',
      'publication_date' => 'publication_date',
      'quarter' => 'quarter',
      'quarter_quarter' => 'quarter_quarter',
      'quonset' => 'quonset',
      'quonset_sqft' => 'quonset_sqft',
      'range' => 'range',
      'recording_date' => 'recording_date',
      'roof_cover' => 'roof_cover',
      'roof_frame' => 'roof_frame',
      'rooms' => 'rooms',
      'rv_parking' => 'rv_parking',
      'safe_room' => 'safe_room',
      'sale_amount' => 'sale_amount',
      'sale_date' => 'sale_date',
      'sauna' => 'sauna',
      'section' => 'section',
      'security_alarm' => 'security_alarm',
      'senior_tax_exemption' => 'senior_tax_exemption',
      'sewer_type' => 'sewer_type',
      'shed' => 'shed',
      'shed_sqft' => 'shed_sqft',
      'silo' => 'silo',
      'silo_sqft' => 'silo_sqft',
      'sitting_room' => 'sitting_room',
      'situs_county' => 'situs_county',
      'situs_state' => 'situs_state',
      'sound_system' => 'sound_system',
      'sports_court' => 'sports_court',
      'sprinklers' => 'sprinklers',
      'stable' => 'stable',
      'stable_sqft' => 'stable_sqft',
      'storage_building' => 'storage_building',
      'storage_building_sqft' => 'storage_building_sqft',
      'stories_number' => 'stories_number',
      'storm_shelter' => 'storm_shelter',
      'storm_shutter' => 'storm_shutter',
      'structure_style' => 'structure_style',
      'study' => 'study',
      'subdivision' => 'subdivision',
      'suffix' => 'suffix',
      'suffix_2' => 'suffix_2',
      'suffix_3' => 'suffix_3',
      'suffix_4' => 'suffix_4',
      'sunroom' => 'sunroom',
      'tax_assess_year' => 'tax_assess_year',
      'tax_billed_amount' => 'tax_billed_amount',
      'tax_delinquent_year' => 'tax_delinquent_year',
      'tax_fiscal_year' => 'tax_fiscal_year',
      'tax_jurisdiction' => 'tax_jurisdiction',
      'tax_rate_area' => 'tax_rate_area',
      'tennis_court' => 'tennis_court',
      'topography_code' => 'topography_code',
      'total_market_value' => 'total_market_value',
      'township' => 'township',
      'tract_number' => 'tract_number',
      'transfer_amount' => 'transfer_amount',
      'trust_description' => 'trust_description',
      'unit_count' => 'unit_count',
      'upper_floors_sqft' => 'upper_floors_sqft',
      'utility' => 'utility',
      'utility_building' => 'utility_building',
      'utility_building_sqft' => 'utility_building_sqft',
      'utility_sqft' => 'utility_sqft',
      'veteran_tax_exemption' => 'veteran_tax_exemption',
      'view_description' => 'view_description',
      'water_feature' => 'water_feature',
      'water_service_type' => 'water_service_type',
      'wet_bar' => 'wet_bar',
      'widow_tax_exemption' => 'widow_tax_exemption',
      'width_linear_footage' => 'width_linear_footage',
      'wine_cellar' => 'wine_cellar',
      'year_built' => 'year_built',
      'zoning' => 'zoning'
    }

    obj = {
      'smarty_key' => 'xxx',
      'data_set' => 'property',
      'data_sub_set' => 'principal',
      'attributes' => attributes_obj
    }

    response = SmartyStreets::USEnrichment::Property::Principal::Response.new(obj)

    assert_equal('xxx', response.smarty_key)
    assert_equal('property', response.data_set)
    assert_equal('principal', response.data_sub_set)

    attributes = response.attributes

    assert_equal('1st_floor_sqft', attributes.first_floor_sqft)
    assert_equal('2nd_floor_sqft', attributes.second_floor_sqft)
    assert_equal('acres', attributes.acres)
    assert_equal('air_conditioner', attributes.air_conditioner)
    assert_equal('arbor_pergola', attributes.arbor_pergola)
    assert_equal('assessed_improvement_percent', attributes.assessed_improvement_percent)
    assert_equal('assessed_improvement_value', attributes.assessed_improvement_value)
    assert_equal('assessed_land_value', attributes.assessed_land_value)
    assert_equal('assessed_value', attributes.assessed_value)
    assert_equal('assessor_last_update', attributes.assessor_last_update)
    assert_equal('assessor_taxroll_update', attributes.assessor_taxroll_update)
    assert_equal('attic_area', attributes.attic_area)
    assert_equal('attic_flag', attributes.attic_flag)
    assert_equal('balcony', attributes.balcony)
    assert_equal('balcony_area', attributes.balcony_area)
    assert_equal('basement_sqft', attributes.basement_sqft)
    assert_equal('basement_sqft_finished', attributes.basement_sqft_finished)
    assert_equal('basement_sqft_unfinished', attributes.basement_sqft_unfinished)
    assert_equal('bath_house', attributes.bath_house)
    assert_equal('bath_house_sqft', attributes.bath_house_sqft)
    assert_equal('bathrooms_partial', attributes.bathrooms_partial)
    assert_equal('bathrooms_total', attributes.bathrooms_total)
    assert_equal('bedrooms', attributes.bedrooms)
    assert_equal('block1', attributes.block1)
    assert_equal('block2', attributes.block2)
    assert_equal('boat_access', attributes.boat_access)
    assert_equal('boat_house', attributes.boat_house)
    assert_equal('boat_house_sqft', attributes.boat_house_sqft)
    assert_equal('boat_lift', attributes.boat_lift)
    assert_equal('bonus_room', attributes.bonus_room)
    assert_equal('breakfast_nook', attributes.breakfast_nook)
    assert_equal('breezeway', attributes.breezeway)
    assert_equal('building_definition_code', attributes.building_definition_code)
    assert_equal('building_sqft', attributes.building_sqft)
    assert_equal('cabin', attributes.cabin)
    assert_equal('cabin_sqft', attributes.cabin_sqft)
    assert_equal('canopy', attributes.canopy)
    assert_equal('canopy_sqft', attributes.canopy_sqft)
    assert_equal('carport', attributes.carport)
    assert_equal('carport_sqft', attributes.carport_sqft)
    assert_equal('cbsa_code', attributes.cbsa_code)
    assert_equal('cbsa_name', attributes.cbsa_name)
    assert_equal('cellar', attributes.cellar)
    assert_equal('census_block', attributes.census_block)
    assert_equal('census_block_group', attributes.census_block_group)
    assert_equal('census_fips_place_code', attributes.census_fips_place_code)
    assert_equal('census_tract', attributes.census_tract)
    assert_equal('central_vacuum', attributes.central_vacuum)
    assert_equal('code_title_company', attributes.code_title_company)
    assert_equal('combined_statistical_area', attributes.combined_statistical_area)
    assert_equal('community_rec', attributes.community_rec)
    assert_equal('company_flag', attributes.company_flag)
    assert_equal('congressional_district', attributes.congressional_district)
    assert_equal('construction_type', attributes.construction_type)
    assert_equal('contact_city', attributes.contact_city)
    assert_equal('contact_crrt', attributes.contact_crrt)
    assert_equal('contact_full_address', attributes.contact_full_address)
    assert_equal('contact_house_number', attributes.contact_house_number)
    assert_equal('contact_mail_info_format', attributes.contact_mail_info_format)
    assert_equal('contact_mail_info_privacy', attributes.contact_mail_info_privacy)
    assert_equal('contact_mailing_county', attributes.contact_mailing_county)
    assert_equal('contact_mailing_fips', attributes.contact_mailing_fips)
    assert_equal('contact_post_direction', attributes.contact_post_direction)
    assert_equal('contact_pre_direction', attributes.contact_pre_direction)
    assert_equal('contact_state', attributes.contact_state)
    assert_equal('contact_street_name', attributes.contact_street_name)
    assert_equal('contact_suffix', attributes.contact_suffix)
    assert_equal('contact_unit_designator', attributes.contact_unit_designator)
    assert_equal('contact_value', attributes.contact_value)
    assert_equal('contact_zip', attributes.contact_zip)
    assert_equal('contact_zip4', attributes.contact_zip4)
    assert_equal('courtyard', attributes.courtyard)
    assert_equal('courtyard_area', attributes.courtyard_area)
    assert_equal('deck', attributes.deck)
    assert_equal('deck_area', attributes.deck_area)
    assert_equal('deed_document_page', attributes.deed_document_page)
    assert_equal('deed_document_book', attributes.deed_document_book)
    assert_equal('deed_document_number', attributes.deed_document_number)
    assert_equal('deed_owner_first_name', attributes.deed_owner_first_name)
    assert_equal('deed_owner_first_name2', attributes.deed_owner_first_name2)
    assert_equal('deed_owner_first_name3', attributes.deed_owner_first_name3)
    assert_equal('deed_owner_first_name4', attributes.deed_owner_first_name4)
    assert_equal('deed_owner_full_name', attributes.deed_owner_full_name)
    assert_equal('deed_owner_full_name2', attributes.deed_owner_full_name2)
    assert_equal('deed_owner_full_name3', attributes.deed_owner_full_name3)
    assert_equal('deed_owner_full_name4', attributes.deed_owner_full_name4)
    assert_equal('deed_owner_last_name', attributes.deed_owner_last_name)
    assert_equal('deed_owner_last_name2', attributes.deed_owner_last_name2)
    assert_equal('deed_owner_last_name3', attributes.deed_owner_last_name3)
    assert_equal('deed_owner_last_name4', attributes.deed_owner_last_name4)
    assert_equal('deed_owner_middle_name', attributes.deed_owner_middle_name)
    assert_equal('deed_owner_middle_name2', attributes.deed_owner_middle_name2)
    assert_equal('deed_owner_middle_name3', attributes.deed_owner_middle_name3)
    assert_equal('deed_owner_middle_name4', attributes.deed_owner_middle_name4)
    assert_equal('deed_owner_suffix', attributes.deed_owner_suffix)
    assert_equal('deed_owner_suffix2', attributes.deed_owner_suffix2)
    assert_equal('deed_owner_suffix3', attributes.deed_owner_suffix3)
    assert_equal('deed_owner_suffix4', attributes.deed_owner_suffix4)
    assert_equal('deed_sale_date', attributes.deed_sale_date)
    assert_equal('deed_sale_price', attributes.deed_sale_price)
    assert_equal('deed_transaction_id', attributes.deed_transaction_id)
    assert_equal('depth_linear_footage', attributes.depth_linear_footage)
    assert_equal('disabled_tax_exemption', attributes.disabled_tax_exemption)
    assert_equal('driveway_sqft', attributes.driveway_sqft)
    assert_equal('driveway_type', attributes.driveway_type)
    assert_equal('effective_year_built', attributes.effective_year_built)
    assert_equal('elevation_feet', attributes.elevation_feet)
    assert_equal('elevator', attributes.elevator)
    assert_equal('equestrian_arena', attributes.equestrian_arena)
    assert_equal('escalator', attributes.escalator)
    assert_equal('exercise_room', attributes.exercise_room)
    assert_equal('exterior_walls', attributes.exterior_walls)
    assert_equal('family_room', attributes.family_room)
    assert_equal('fence', attributes.fence)
    assert_equal('fence_area', attributes.fence_area)
    assert_equal('fips_code', attributes.fips_code)
    assert_equal('fire_resistance_code', attributes.fire_resistance_code)
    assert_equal('fire_sprinklers_flag', attributes.fire_sprinklers_flag)
    assert_equal('fireplace', attributes.fireplace)
    assert_equal('fireplace_number', attributes.fireplace_number)
    assert_equal('first_name', attributes.first_name)
    assert_equal('first_name_2', attributes.first_name_2)
    assert_equal('first_name_3', attributes.first_name_3)
    assert_equal('first_name_4', attributes.first_name_4)
    assert_equal('flooring', attributes.flooring)
    assert_equal('foundation', attributes.foundation)
    assert_equal('game_room', attributes.game_room)
    assert_equal('garage', attributes.garage)
    assert_equal('garage_sqft', attributes.garage_sqft)
    assert_equal('gazebo', attributes.gazebo)
    assert_equal('gazebo_sqft', attributes.gazebo_sqft)
    assert_equal('golf_course', attributes.golf_course)
    assert_equal('grainery', attributes.grainery)
    assert_equal('grainery_sqft', attributes.grainery_sqft)
    assert_equal('great_room', attributes.great_room)
    assert_equal('greenhouse', attributes.greenhouse)
    assert_equal('greenhouse_sqft', attributes.greenhouse_sqft)
    assert_equal('gross_sqft', attributes.gross_sqft)
    assert_equal('guesthouse', attributes.guesthouse)
    assert_equal('guesthouse_sqft', attributes.guesthouse_sqft)
    assert_equal('handicap_accessibility', attributes.handicap_accessibility)
    assert_equal('heat', attributes.heat)
    assert_equal('heat_fuel_type', attributes.heat_fuel_type)
    assert_equal('hobby_room', attributes.hobby_room)
    assert_equal('homeowner_tax_exemption', attributes.homeowner_tax_exemption)
    assert_equal('instrument_date', attributes.instrument_date)
    assert_equal('intercom_system', attributes.intercom_system)
    assert_equal('interest_rate_type_2', attributes.interest_rate_type_2)
    assert_equal('interior_structure', attributes.interior_structure)
    assert_equal('kennel', attributes.kennel)
    assert_equal('kennel_sqft', attributes.kennel_sqft)
    assert_equal('land_use_code', attributes.land_use_code)
    assert_equal('land_use_group', attributes.land_use_group)
    assert_equal('land_use_standard', attributes.land_use_standard)
    assert_equal('last_name', attributes.last_name)
    assert_equal('last_name_2', attributes.last_name_2)
    assert_equal('last_name_3', attributes.last_name_3)
    assert_equal('last_name_4', attributes.last_name_4)
    assert_equal('latitude', attributes.latitude)
    assert_equal('laundry', attributes.laundry)
    assert_equal('lean_to', attributes.lean_to)
    assert_equal('lean_to_sqft', attributes.lean_to_sqft)
    assert_equal('legal_description', attributes.legal_description)
    assert_equal('legal_unit', attributes.legal_unit)
    assert_equal('lender_address', attributes.lender_address)
    assert_equal('lender_address_2', attributes.lender_address_2)
    assert_equal('lender_city', attributes.lender_city)
    assert_equal('lender_city_2', attributes.lender_city_2)
    assert_equal('lender_code_2', attributes.lender_code_2)
    assert_equal('lender_first_name', attributes.lender_first_name)
    assert_equal('lender_first_name_2', attributes.lender_first_name_2)
    assert_equal('lender_last_name', attributes.lender_last_name)
    assert_equal('lender_last_name_2', attributes.lender_last_name_2)
    assert_equal('lender_name', attributes.lender_name)
    assert_equal('lender_name_2', attributes.lender_name_2)
    assert_equal('lender_seller_carry_back', attributes.lender_seller_carry_back)
    assert_equal('lender_seller_carry_back_2', attributes.lender_seller_carry_back_2)
    assert_equal('lender_state', attributes.lender_state)
    assert_equal('lender_state_2', attributes.lender_state_2)
    assert_equal('lender_zip', attributes.lender_zip)
    assert_equal('lender_zip_2', attributes.lender_zip_2)
    assert_equal('lender_zip_extended', attributes.lender_zip_extended)
    assert_equal('lender_zip_extended_2', attributes.lender_zip_extended_2)
    assert_equal('loading_platform', attributes.loading_platform)
    assert_equal('loading_platform_sqft', attributes.loading_platform_sqft)
    assert_equal('longitude', attributes.longitude)
    assert_equal('lot_1', attributes.lot_1)
    assert_equal('lot_2', attributes.lot_2)
    assert_equal('lot_3', attributes.lot_3)
    assert_equal('lot_sqft', attributes.lot_sqft)
    assert_equal('market_improvement_percent', attributes.market_improvement_percent)
    assert_equal('market_improvement_value', attributes.market_improvement_value)
    assert_equal('market_land_value', attributes.market_land_value)
    assert_equal('market_value_year', attributes.market_value_year)
    assert_equal('match_type', attributes.match_type)
    assert_equal('media_room', attributes.media_room)
    assert_equal('metro_division', attributes.metro_division)
    assert_equal('middle_name', attributes.middle_name)
    assert_equal('middle_name_2', attributes.middle_name_2)
    assert_equal('middle_name_3', attributes.middle_name_3)
    assert_equal('middle_name_4', attributes.middle_name_4)
    assert_equal('milkhouse', attributes.milkhouse)
    assert_equal('milkhouse_sqft', attributes.milkhouse_sqft)
    assert_equal('minor_civil_division_code', attributes.minor_civil_division_code)
    assert_equal('minor_civil_division_name', attributes.minor_civil_division_name)
    assert_equal('mobile_home_hookup', attributes.mobile_home_hookup)
    assert_equal('mortgage_amount', attributes.mortgage_amount)
    assert_equal('mortgage_amount_2', attributes.mortgage_amount_2)
    assert_equal('mortgage_due_date', attributes.mortgage_due_date)
    assert_equal('mortgage_due_date_2', attributes.mortgage_due_date_2)
    assert_equal('mortgage_interest_rate', attributes.mortgage_interest_rate)
    assert_equal('mortgage_interest_rate_type', attributes.mortgage_interest_rate_type)
    assert_equal('mortgage_lender_code', attributes.mortgage_lender_code)
    assert_equal('mortgage_rate_2', attributes.mortgage_rate_2)
    assert_equal('mortgage_recording_date', attributes.mortgage_recording_date)
    assert_equal('mortgage_recording_date_2', attributes.mortgage_recording_date_2)
    assert_equal('mortgage_term', attributes.mortgage_term)
    assert_equal('mortgage_term_2', attributes.mortgage_term_2)
    assert_equal('mortgage_term_type', attributes.mortgage_term_type)
    assert_equal('mortgage_term_type_2', attributes.mortgage_term_type_2)
    assert_equal('mortgage_type', attributes.mortgage_type)
    assert_equal('mortgage_type_2', attributes.mortgage_type_2)
    assert_equal('msa_code', attributes.msa_code)
    assert_equal('msa_name', attributes.msa_name)
    assert_equal('mud_room', attributes.mud_room)
    assert_equal('multi_parcel_flag', attributes.multi_parcel_flag)
    assert_equal('name_title_company', attributes.name_title_company)
    assert_equal('neighborhood_code', attributes.neighborhood_code)
    assert_equal('number_of_buildings', attributes.number_of_buildings)
    assert_equal('office', attributes.office)
    assert_equal('office_sqft', attributes.office_sqft)
    assert_equal('other_tax_exemption', attributes.other_tax_exemption)
    assert_equal('outdoor_kitchen_fireplace', attributes.outdoor_kitchen_fireplace)
    assert_equal('overhead_door', attributes.overhead_door)
    assert_equal('owner_full_name', attributes.owner_full_name)
    assert_equal('owner_full_name_2', attributes.owner_full_name_2)
    assert_equal('owner_full_name_3', attributes.owner_full_name_3)
    assert_equal('owner_full_name_4', attributes.owner_full_name_4)
    assert_equal('owner_occupancy_status', attributes.owner_occupancy_status)
    assert_equal('ownership_transfer_date', attributes.ownership_transfer_date)
    assert_equal('ownership_transfer_doc_number', attributes.ownership_transfer_doc_number)
    assert_equal('ownership_transfer_transaction_id', attributes.ownership_transfer_transaction_id)
    assert_equal('ownership_type', attributes.ownership_type)
    assert_equal('ownership_type_2', attributes.ownership_type_2)
    assert_equal('ownership_vesting_relation_code', attributes.ownership_vesting_relation_code)
    assert_equal('parcel_account_number', attributes.parcel_account_number)
    assert_equal('parcel_map_book', attributes.parcel_map_book)
    assert_equal('parcel_map_page', attributes.parcel_map_page)
    assert_equal('parcel_number_alternate', attributes.parcel_number_alternate)
    assert_equal('parcel_number_formatted', attributes.parcel_number_formatted)
    assert_equal('parcel_number_previous', attributes.parcel_number_previous)
    assert_equal('parcel_number_year_added', attributes.parcel_number_year_added)
    assert_equal('parcel_number_year_change', attributes.parcel_number_year_change)
    assert_equal('parcel_raw_number', attributes.parcel_raw_number)
    assert_equal('parcel_shell_record', attributes.parcel_shell_record)
    assert_equal('parking_spaces', attributes.parking_spaces)
    assert_equal('patio_area', attributes.patio_area)
    assert_equal('phase_name', attributes.phase_name)
    assert_equal('plumbing_fixtures_count', attributes.plumbing_fixtures_count)
    assert_equal('pole_struct', attributes.pole_struct)
    assert_equal('pole_struct_sqft', attributes.pole_struct_sqft)
    assert_equal('pond', attributes.pond)
    assert_equal('pool', attributes.pool)
    assert_equal('pool_area', attributes.pool_area)
    assert_equal('poolhouse', attributes.poolhouse)
    assert_equal('poolhouse_sqft', attributes.poolhouse_sqft)
    assert_equal('porch', attributes.porch)
    assert_equal('porch_area', attributes.porch_area)
    assert_equal('poultry_house', attributes.poultry_house)
    assert_equal('poultry_house_sqft', attributes.poultry_house_sqft)
    assert_equal('previous_assessed_value', attributes.previous_assessed_value)
    assert_equal('prior_sale_amount', attributes.prior_sale_amount)
    assert_equal('prior_sale_date', attributes.prior_sale_date)
    assert_equal('property_address_carrier_route_code', attributes.property_address_carrier_route_code)
    assert_equal('property_address_city', attributes.property_address_city)
    assert_equal('property_address_full', attributes.property_address_full)
    assert_equal('property_address_house_number', attributes.property_address_house_number)
    assert_equal('property_address_post_direction', attributes.property_address_post_direction)
    assert_equal('property_address_pre_direction', attributes.property_address_pre_direction)
    assert_equal('property_address_state', attributes.property_address_state)
    assert_equal('property_address_street_name', attributes.property_address_street_name)
    assert_equal('property_address_street_suffix', attributes.property_address_street_suffix)
    assert_equal('property_address_unit_designator', attributes.property_address_unit_designator)
    assert_equal('property_address_unit_value', attributes.property_address_unit_value)
    assert_equal('property_address_zip_4', attributes.property_address_zip_4)
    assert_equal('property_address_zipcode', attributes.property_address_zipcode)
    assert_equal('publication_date', attributes.publication_date)
    assert_equal('quarter', attributes.quarter)
    assert_equal('quarter_quarter', attributes.quarter_quarter)
    assert_equal('quonset', attributes.quonset)
    assert_equal('quonset_sqft', attributes.quonset_sqft)
    assert_equal('range', attributes.range)
    assert_equal('recording_date', attributes.recording_date)
    assert_equal('roof_cover', attributes.roof_cover)
    assert_equal('roof_frame', attributes.roof_frame)
    assert_equal('rooms', attributes.rooms)
    assert_equal('rv_parking', attributes.rv_parking)
    assert_equal('safe_room', attributes.safe_room)
    assert_equal('sale_amount', attributes.sale_amount)
    assert_equal('sale_date', attributes.sale_date)
    assert_equal('sauna', attributes.sauna)
    assert_equal('section', attributes.section)
    assert_equal('security_alarm', attributes.security_alarm)
    assert_equal('senior_tax_exemption', attributes.senior_tax_exemption)
    assert_equal('sewer_type', attributes.sewer_type)
    assert_equal('shed', attributes.shed)
    assert_equal('shed_sqft', attributes.shed_sqft)
    assert_equal('silo', attributes.silo)
    assert_equal('silo_sqft', attributes.silo_sqft)
    assert_equal('sitting_room', attributes.sitting_room)
    assert_equal('situs_county', attributes.situs_county)
    assert_equal('situs_state', attributes.situs_state)
    assert_equal('sound_system', attributes.sound_system)
    assert_equal('sports_court', attributes.sports_court)
    assert_equal('sprinklers', attributes.sprinklers)
    assert_equal('stable', attributes.stable)
    assert_equal('stable_sqft', attributes.stable_sqft)
    assert_equal('storage_building', attributes.storage_building)
    assert_equal('storage_building_sqft', attributes.storage_building_sqft)
    assert_equal('stories_number', attributes.stories_number)
    assert_equal('storm_shelter', attributes.storm_shelter)
    assert_equal('storm_shutter', attributes.storm_shutter)
    assert_equal('structure_style', attributes.structure_style)
    assert_equal('study', attributes.study)
    assert_equal('subdivision', attributes.subdivision)
    assert_equal('suffix', attributes.suffix)
    assert_equal('suffix_2', attributes.suffix_2)
    assert_equal('suffix_3', attributes.suffix_3)
    assert_equal('suffix_4', attributes.suffix_4)
    assert_equal('sunroom', attributes.sunroom)
    assert_equal('tax_assess_year', attributes.tax_assess_year)
    assert_equal('tax_billed_amount', attributes.tax_billed_amount)
    assert_equal('tax_delinquent_year', attributes.tax_delinquent_year)
    assert_equal('tax_fiscal_year', attributes.tax_fiscal_year)
    assert_equal('tax_jurisdiction', attributes.tax_jurisdiction)
    assert_equal('tax_rate_area', attributes.tax_rate_area)
    assert_equal('tennis_court', attributes.tennis_court)
    assert_equal('topography_code', attributes.topography_code)
    assert_equal('total_market_value', attributes.total_market_value)
    assert_equal('township', attributes.township)
    assert_equal('tract_number', attributes.tract_number)
    assert_equal('transfer_amount', attributes.transfer_amount)
    assert_equal('trust_description', attributes.trust_description)
    assert_equal('unit_count', attributes.unit_count)
    assert_equal('upper_floors_sqft', attributes.upper_floors_sqft)
    assert_equal('utility', attributes.utility)
    assert_equal('utility_building', attributes.utility_building)
    assert_equal('utility_building_sqft', attributes.utility_building_sqft)
    assert_equal('utility_sqft', attributes.utility_sqft)
    assert_equal('veteran_tax_exemption', attributes.veteran_tax_exemption)
    assert_equal('view_description', attributes.view_description)
    assert_equal('water_feature', attributes.water_feature)
    assert_equal('water_service_type', attributes.water_service_type)
    assert_equal('wet_bar', attributes.wet_bar)
    assert_equal('widow_tax_exemption', attributes.widow_tax_exemption)
    assert_equal('width_linear_footage', attributes.width_linear_footage)
    assert_equal('wine_cellar', attributes.wine_cellar)
    assert_equal('year_built', attributes.year_built)
    assert_equal('zoning', attributes.zoning)
  end
end

module SmartyStreets
  module USEnrichment
    module Property
      module Principal
        class TestAttributes < Minitest::Test
          def test_attribute_assignment
            sample = {
              '1st_floor_sqft' => 123,
              '2nd_floor_sqft' => 456,
              'acres' => 1.5,
              'air_conditioner' => true,
              'zoning' => 'Residential'
            }
            attrs = Attributes.new(sample)
            assert_equal 123, attrs.first_floor_sqft
            assert_equal 456, attrs.second_floor_sqft
            assert_equal 1.5, attrs.acres
            assert_equal true, attrs.air_conditioner
            assert_equal 'Residential', attrs.zoning
          end

          def test_missing_keys_are_nil
            attrs = Attributes.new({})
            assert_nil attrs.first_floor_sqft
            assert_nil attrs.zoning
          end
        end
      end
    end
  end
end
