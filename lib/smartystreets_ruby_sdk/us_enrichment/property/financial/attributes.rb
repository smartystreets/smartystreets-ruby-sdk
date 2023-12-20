require_relative 'history_entry'

module SmartyStreets
    module USEnrichment
        module Property:
            module Financial:
                class Attributes
                    attr_reader :assessed_improvement_percent, :assessed_improvement_value, :assessed_land_value, :assessed_value, 
                    :assessor_last_update, :assessor_taxroll_update, :contact_city, :contact_crrt, :contact_full_address, :contact_house_number, 
                    :contact_mail_info_format, :contact_mail_info_privacy, :contact_mailing_county, :contact_mailing_fips, :contact_post_direction, 
                    :contact_pre_direction, :contact_state, :contact_street_name, :contact_suffix, :contact_unit_designator, :contact_value, 
                    :contact_zip, :contact_zip4, :deed_document_page, :deed_document_book, :deed_document_number, :deed_owner_first_name, 
                    :deed_owner_first_name2, :deed_owner_first_name3, :deed_owner_first_name4, :deed_owner_full_name, :deed_owner_full_name2, 
                    :deed_owner_full_name3, :deed_owner_full_name4, :deed_owner_last_name, :deed_owner_last_name2, :deed_owner_last_name3, 
                    :deed_owner_last_name4, :deed_owner_middle_name, :deed_owner_middle_name2, :deed_owner_middle_name3, :deed_owner_middle_name4, 
                    :deed_owner_suffix, :deed_owner_suffix2, :deed_owner_suffix3, :deed_owner_suffix4, :deed_sale_date, :deed_sale_price, 
                    :deed_transaction_id, :disabled_tax_exemption, :financial_history, :first_name, :first_name_2, :first_name_3, :first_name_4, 
                    :homeowner_tax_exemption, :last_name, :last_name_2, :last_name_3, :last_name_4, :market_improvement_percent, :market_improvement_value, 
                    :market_land_value, :market_value_year, :match_type, :middle_name, :middle_name_2, :middle_name_3, :middle_name_4, :other_tax_exemption, 
                    :owner_full_name, :owner_full_name_2, :owner_full_name_3, :owner_full_name_4, :ownership_transfer_date, :ownership_transfer_doc_number, 
                    :ownership_transfer_transaction_id, :ownership_type, :ownership_type_2, :previous_assessed_value, :prior_sale_amount, :prior_sale_date, 
                    :sale_amount, :sale_date, :senior_tax_exemption, :suffix, :suffix_2, :suffix_3, :suffix_4, :tax_assess_year, :tax_billed_amount, 
                    :tax_delinquent_year, :tax_fiscal_year, :tax_rate_area, :total_market_value, :trust_description, :veteran_tax_exemption, :widow_tax_exemption
            
                    def initialize(obj)
                        @assessed_improvement_percent = obj['assessed_improvement_percent']
                        @assessed_improvement_value = obj['assessed_improvement_value']
                        @assessed_land_value = obj['assessed_land_value']
                        @assessed_value = obj['assessed_value']
                        @assessor_last_update = obj['assessor_last_update']
                        @assessor_taxroll_update = obj['assessor_taxroll_update']
                        @contact_city = obj['contact_city']
                        @contact_crrt = obj['contact_crrt']
                        @contact_full_address = obj['contact_full_address']
                        @contact_house_number = obj['contact_house_number']
                        @contact_mail_info_format = obj['contact_mail_info_format']
                        @contact_mail_info_privacy = obj['contact_mail_info_privacy']
                        @contact_mailing_county = obj['contact_mailing_county']
                        @contact_mailing_fips = obj['contact_mailing_fips']
                        @contact_post_direction = obj['contact_post_direction']
                        @contact_pre_direction = obj['contact_pre_direction']
                        @contact_state = obj['contact_state']
                        @contact_street_name = obj['contact_street_name']
                        @contact_suffix = obj['contact_suffix']
                        @contact_unit_designator = obj['contact_unit_designator']
                        @contact_value = obj['contact_value']
                        @contact_zip = obj['contact_zip']
                        @contact_zip4 = obj['contact_zip4']
                        @deed_document_page = obj['deed_document_page']
                        @deed_document_book = obj['deed_document_book']
                        @deed_document_number = obj['deed_document_number']
                        @deed_owner_first_name = obj['deed_owner_first_name']
                        @deed_owner_first_name2 = obj['deed_owner_first_name2']
                        @deed_owner_first_name3 = obj['deed_owner_first_name3']
                        @deed_owner_first_name4 = obj['deed_owner_first_name4']
                        @deed_owner_full_name = obj['deed_owner_full_name']
                        @deed_owner_full_name2 = obj['deed_owner_full_name2']
                        @deed_owner_full_name3 = obj['deed_owner_full_name3']
                        @deed_owner_full_name4 = obj['deed_owner_full_name4']
                        @deed_owner_last_name = obj['deed_owner_last_name']
                        @deed_owner_last_name2 = obj['deed_owner_last_name2']
                        @deed_owner_last_name3 = obj['deed_owner_last_name3']
                        @deed_owner_last_name4 = obj['deed_owner_last_name4']
                        @deed_owner_middle_name = obj['deed_owner_middle_name']
                        @deed_owner_middle_name2 = obj['deed_owner_middle_name2']
                        @deed_owner_middle_name3 = obj['deed_owner_middle_name3']
                        @deed_owner_middle_name4 = obj['deed_owner_middle_name4']
                        @deed_owner_suffix = obj['deed_owner_suffix']
                        @deed_owner_suffix2 = obj['deed_owner_suffix2']
                        @deed_owner_suffix3 = obj['deed_owner_suffix3']
                        @deed_owner_suffix4 = obj['deed_owner_suffix4']
                        @deed_sale_date = obj['deed_sale_date']
                        @deed_sale_price = obj['deed_sale_price']
                        @deed_transaction_id = obj['deed_transaction_id']
                        @disabled_tax_exemption = obj['disabled_tax_exemption']
                        @financial_history = createFinancialHistory(obj['financial_history'])
                        @first_name = obj['first_name']
                        @first_name_2 = obj['first_name_2']
                        @first_name_3 = obj['first_name_3']
                        @first_name_4 = obj['first_name_4']
                        @homeowner_tax_exemption = obj['homeowner_tax_exemption']
                        @last_name = obj['last_name']
                        @last_name_2 = obj['last_name_2']
                        @last_name_3 = obj['last_name_3']
                        @last_name_4 = obj['last_name_4']
                        @market_improvement_percent = obj['market_improvement_percent']
                        @market_improvement_value = obj['market_improvement_value']
                        @market_land_value = obj['market_land_value']
                        @market_value_year = obj['market_value_year']
                        @match_type = obj['match_type']
                        @middle_name = obj['middle_name']
                        @middle_name_2 = obj['middle_name_2']
                        @middle_name_3 = obj['middle_name_3']
                        @middle_name_4 = obj['middle_name_4']
                        @other_tax_exemption = obj['other_tax_exemption']
                        @owner_full_name = obj['owner_full_name']
                        @owner_full_name_2 = obj['owner_full_name_2']
                        @owner_full_name_3 = obj['owner_full_name_3']
                        @owner_full_name_4 = obj['owner_full_name_4']
                        @ownership_transfer_date = obj['ownership_transfer_date']
                        @ownership_transfer_doc_number = obj['ownership_transfer_doc_number']
                        @ownership_transfer_transaction_id = obj['ownership_transfer_transaction_id']
                        @ownership_type = obj['ownership_type']
                        @ownership_type_2 = obj['ownership_type_2']
                        @previous_assessed_value = obj['previous_assessed_value']
                        @prior_sale_amount = obj['prior_sale_amount']
                        @prior_sale_date = obj['prior_sale_date']
                        @sale_amount = obj['sale_amount']
                        @sale_date = obj['sale_date']
                        @senior_tax_exemption = obj['senior_tax_exemption']
                        @suffix = obj['suffix']
                        @suffix_2 = obj['suffix_2']
                        @suffix_3 = obj['suffix_3']
                        @suffix_4 = obj['suffix_4']
                        @tax_assess_year = obj['tax_assess_year']
                        @tax_billed_amount = obj['tax_billed_amount']
                        @tax_delinquent_year = obj['tax_delinquent_year']
                        @tax_fiscal_year = obj['tax_fiscal_year']
                        @tax_rate_area = obj['tax_rate_area']
                        @total_market_value = obj['total_market_value']
                        @trust_description = obj['trust_description']
                        @veteran_tax_exemption = obj['veteran_tax_exemption']
                        @widow_tax_exemption = obj['widow_tax_exemption']
                    end
                    
                    def createFinancialHistory(historyArray)
                        entryArray = []
                        for entry in historyArray do
                            entryArray << FinancialHistoryEntry.new(entry)
                        end
                        return entryArray
                    end
                end
            end
        end
    end
end