# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../../lib/smartystreets_ruby_sdk/us_enrichment/property/financial/response'
require_relative '../../test_helper'
require 'smartystreets_ruby_sdk/us_enrichment/property/financial/attributes'
require 'smartystreets_ruby_sdk/us_enrichment/property/financial/history_entry'

module SmartyStreets
  module USEnrichment
    module Property
      module Financial
        class TestHistoryEntry < Minitest::Test
          def test_attribute_assignment
            sample = {
              'lender_name' => 'Bank',
              'mortgage_amount' => 100_000,
              'recording_date' => '2020-01-01'
            }
            entry = HistoryEntry.new(sample)
            assert_equal 'Bank', entry.lender_name
            assert_equal 100_000, entry.mortgage_amount
            assert_equal '2020-01-01', entry.recording_date
          end

          def test_missing_keys_are_nil
            entry = HistoryEntry.new({})
            assert_nil entry.lender_name
            assert_nil entry.mortgage_amount
          end
        end

        class TestAttributes < Minitest::Test
          def test_attribute_assignment
            sample = {
              'assessed_value' => 500_000,
              'owner_full_name' => 'John Doe',
              'tax_billed_amount' => 2500
            }
            attrs = Attributes.new(sample)
            assert_equal 500_000, attrs.assessed_value
            assert_equal 'John Doe', attrs.owner_full_name
            assert_equal 2500, attrs.tax_billed_amount
          end

          def test_financial_history_array
            sample = {
              'financial_history' => [
                { 'lender_name' => 'Bank1', 'mortgage_amount' => 100_000 },
                { 'lender_name' => 'Bank2', 'mortgage_amount' => 200_000 }
              ]
            }
            attrs = Attributes.new(sample)
            assert_equal 2, attrs.financial_history.size
            assert_equal 'Bank1', attrs.financial_history[0].lender_name
            assert_equal 200_000, attrs.financial_history[1].mortgage_amount
          end
        end
      end
    end
  end
end

class TestPropertyFinancialResponse < Minitest::Test
  def test_all_fields_filled_correctly
    attributes_obj = {
      'assessed_improvement_percent' => 'assessed_improvement_percent',
      'assessed_improvement_value' => 'assessed_improvement_value',
      'assessed_land_value' => 'assessed_land_value',
      'assessed_value' => 'assessed_value',
      'assessor_last_update' => 'assessor_last_update',
      'assessor_taxroll_update' => 'assessor_taxroll_update',
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
      'disabled_tax_exemption' => 'disabled_tax_exemption',
      'financial_history' => [
        {
          'code_title_company' => 'code_title_company',
          'instrument_date' => 'instrument_date',
          'interest_rate_type_2' => 'interest_rate_type_2',
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
          'multi_parcel_flag' => 'multi_parcel_flag',
          'name_title_company' => 'name_title_company',
          'recording_date' => 'recording_date',
          'transfer_amount' => 'transfer_amount'
        }
      ],
      'first_name' => 'first_name',
      'first_name_2' => 'first_name_2',
      'first_name_3' => 'first_name_3',
      'first_name_4' => 'first_name_4',
      'homeowner_tax_exemption' => 'homeowner_tax_exemption',
      'last_name' => 'last_name',
      'last_name_2' => 'last_name_2',
      'last_name_3' => 'last_name_3',
      'last_name_4' => 'last_name_4',
      'market_improvement_percent' => 'market_improvement_percent',
      'market_improvement_value' => 'market_improvement_value',
      'market_land_value' => 'market_land_value',
      'market_value_year' => 'market_value_year',
      'match_type' => 'match_type',
      'middle_name' => 'middle_name',
      'middle_name_2' => 'middle_name_2',
      'middle_name_3' => 'middle_name_3',
      'middle_name_4' => 'middle_name_4',
      'other_tax_exemption' => 'other_tax_exemption',
      'owner_full_name' => 'owner_full_name',
      'owner_full_name_2' => 'owner_full_name_2',
      'owner_full_name_3' => 'owner_full_name_3',
      'owner_full_name_4' => 'owner_full_name_4',
      'ownership_transfer_date' => 'ownership_transfer_date',
      'ownership_transfer_doc_number' => 'ownership_transfer_doc_number',
      'ownership_transfer_transaction_id' => 'ownership_transfer_transaction_id',
      'ownership_type' => 'ownership_type',
      'ownership_type_2' => 'ownership_type_2',
      'previous_assessed_value' => 'previous_assessed_value',
      'prior_sale_amount' => 'prior_sale_amount',
      'prior_sale_date' => 'prior_sale_date',
      'sale_amount' => 'sale_amount',
      'sale_date' => 'sale_date',
      'senior_tax_exemption' => 'senior_tax_exemption',
      'suffix' => 'suffix',
      'suffix_2' => 'suffix_2',
      'suffix_3' => 'suffix_3',
      'suffix_4' => 'suffix_4',
      'tax_assess_year' => 'tax_assess_year',
      'tax_billed_amount' => 'tax_billed_amount',
      'tax_delinquent_year' => 'tax_delinquent_year',
      'tax_fiscal_year' => 'tax_fiscal_year',
      'tax_rate_area' => 'tax_rate_area',
      'total_market_value' => 'total_market_value',
      'trust_description' => 'trust_description',
      'veteran_tax_exemption' => 'veteran_tax_exemption',
      'widow_tax_exemption' => 'widow_tax_exemption'
    }

    obj = {
      'smarty_key' => 'xxx',
      'data_set' => 'property',
      'data_sub_set' => 'financial',
      'attributes' => attributes_obj
    }

    response = SmartyStreets::USEnrichment::Property::Financial::Response.new(obj)

    assert_equal('xxx', response.smarty_key)
    assert_equal('property', response.data_set)
    assert_equal('financial', response.data_sub_set)

    attributes = response.attributes

    assert_equal('assessed_improvement_percent', attributes.assessed_improvement_percent)
    assert_equal('assessed_improvement_value', attributes.assessed_improvement_value)
    assert_equal('assessed_land_value', attributes.assessed_land_value)
    assert_equal('assessed_value', attributes.assessed_value)
    assert_equal('assessor_last_update', attributes.assessor_last_update)
    assert_equal('assessor_taxroll_update', attributes.assessor_taxroll_update)
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
    assert_equal('disabled_tax_exemption', attributes.disabled_tax_exemption)

    financial_history = attributes.financial_history[0]

    assert_equal('code_title_company', financial_history.code_title_company)
    assert_equal('instrument_date', financial_history.instrument_date)
    assert_equal('interest_rate_type_2', financial_history.interest_rate_type_2)
    assert_equal('lender_address', financial_history.lender_address)
    assert_equal('lender_address_2', financial_history.lender_address_2)
    assert_equal('lender_city', financial_history.lender_city)
    assert_equal('lender_city_2', financial_history.lender_city_2)
    assert_equal('lender_code_2', financial_history.lender_code_2)
    assert_equal('lender_first_name', financial_history.lender_first_name)
    assert_equal('lender_first_name_2', financial_history.lender_first_name_2)
    assert_equal('lender_last_name', financial_history.lender_last_name)
    assert_equal('lender_last_name_2', financial_history.lender_last_name_2)
    assert_equal('lender_name', financial_history.lender_name)
    assert_equal('lender_name_2', financial_history.lender_name_2)
    assert_equal('lender_seller_carry_back', financial_history.lender_seller_carry_back)
    assert_equal('lender_seller_carry_back_2', financial_history.lender_seller_carry_back_2)
    assert_equal('lender_state', financial_history.lender_state)
    assert_equal('lender_state_2', financial_history.lender_state_2)
    assert_equal('lender_zip', financial_history.lender_zip)
    assert_equal('lender_zip_2', financial_history.lender_zip_2)
    assert_equal('lender_zip_extended', financial_history.lender_zip_extended)
    assert_equal('lender_zip_extended_2', financial_history.lender_zip_extended_2)
    assert_equal('mortgage_amount', financial_history.mortgage_amount)
    assert_equal('mortgage_amount_2', financial_history.mortgage_amount_2)
    assert_equal('mortgage_due_date', financial_history.mortgage_due_date)
    assert_equal('mortgage_due_date_2', financial_history.mortgage_due_date_2)
    assert_equal('mortgage_interest_rate', financial_history.mortgage_interest_rate)
    assert_equal('mortgage_interest_rate_type', financial_history.mortgage_interest_rate_type)
    assert_equal('mortgage_lender_code', financial_history.mortgage_lender_code)
    assert_equal('mortgage_rate_2', financial_history.mortgage_rate_2)
    assert_equal('mortgage_recording_date', financial_history.mortgage_recording_date)
    assert_equal('mortgage_recording_date_2', financial_history.mortgage_recording_date_2)
    assert_equal('mortgage_term', financial_history.mortgage_term)
    assert_equal('mortgage_term_2', financial_history.mortgage_term_2)
    assert_equal('mortgage_term_type', financial_history.mortgage_term_type)
    assert_equal('mortgage_term_type_2', financial_history.mortgage_term_type_2)
    assert_equal('mortgage_type', financial_history.mortgage_type)
    assert_equal('mortgage_type_2', financial_history.mortgage_type_2)
    assert_equal('multi_parcel_flag', financial_history.multi_parcel_flag)
    assert_equal('name_title_company', financial_history.name_title_company)
    assert_equal('recording_date', financial_history.recording_date)
    assert_equal('transfer_amount', financial_history.transfer_amount)

    assert_equal('first_name', attributes.first_name)
    assert_equal('first_name_2', attributes.first_name_2)
    assert_equal('first_name_3', attributes.first_name_3)
    assert_equal('first_name_4', attributes.first_name_4)
    assert_equal('homeowner_tax_exemption', attributes.homeowner_tax_exemption)
    assert_equal('last_name', attributes.last_name)
    assert_equal('last_name_2', attributes.last_name_2)
    assert_equal('last_name_3', attributes.last_name_3)
    assert_equal('last_name_4', attributes.last_name_4)
    assert_equal('market_improvement_percent', attributes.market_improvement_percent)
    assert_equal('market_improvement_value', attributes.market_improvement_value)
    assert_equal('market_land_value', attributes.market_land_value)
    assert_equal('market_value_year', attributes.market_value_year)
    assert_equal('match_type', attributes.match_type)
    assert_equal('middle_name', attributes.middle_name)
    assert_equal('middle_name_2', attributes.middle_name_2)
    assert_equal('middle_name_3', attributes.middle_name_3)
    assert_equal('middle_name_4', attributes.middle_name_4)
    assert_equal('other_tax_exemption', attributes.other_tax_exemption)
    assert_equal('owner_full_name', attributes.owner_full_name)
    assert_equal('owner_full_name_2', attributes.owner_full_name_2)
    assert_equal('owner_full_name_3', attributes.owner_full_name_3)
    assert_equal('owner_full_name_4', attributes.owner_full_name_4)
    assert_equal('ownership_transfer_date', attributes.ownership_transfer_date)
    assert_equal('ownership_transfer_doc_number', attributes.ownership_transfer_doc_number)
    assert_equal('ownership_transfer_transaction_id', attributes.ownership_transfer_transaction_id)
    assert_equal('ownership_type', attributes.ownership_type)
    assert_equal('ownership_type_2', attributes.ownership_type_2)
    assert_equal('previous_assessed_value', attributes.previous_assessed_value)
    assert_equal('prior_sale_amount', attributes.prior_sale_amount)
    assert_equal('prior_sale_date', attributes.prior_sale_date)
    assert_equal('sale_amount', attributes.sale_amount)
    assert_equal('sale_date', attributes.sale_date)
    assert_equal('senior_tax_exemption', attributes.senior_tax_exemption)
    assert_equal('suffix', attributes.suffix)
    assert_equal('suffix_2', attributes.suffix_2)
    assert_equal('suffix_3', attributes.suffix_3)
    assert_equal('suffix_4', attributes.suffix_4)
    assert_equal('tax_assess_year', attributes.tax_assess_year)
    assert_equal('tax_billed_amount', attributes.tax_billed_amount)
    assert_equal('tax_delinquent_year', attributes.tax_delinquent_year)
    assert_equal('tax_fiscal_year', attributes.tax_fiscal_year)
    assert_equal('tax_rate_area', attributes.tax_rate_area)
    assert_equal('total_market_value', attributes.total_market_value)
    assert_equal('trust_description', attributes.trust_description)
    assert_equal('veteran_tax_exemption', attributes.veteran_tax_exemption)
    assert_equal('widow_tax_exemption', attributes.widow_tax_exemption)
  end
end
