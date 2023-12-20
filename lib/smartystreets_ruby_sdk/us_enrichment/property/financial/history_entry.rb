module SmartyStreets
    module USEnrichment
        module Property:
            module Financial:
                class HistoryEntry
                    attr_reader :code_title_company, :instrument_date, :interest_rate_type_2, :lender_address, :lender_address_2, 
                    :lender_city, :lender_city_2, :lender_code_2, :lender_first_name, :lender_first_name_2, :lender_last_name, 
                    :lender_last_name_2, :lender_name, :lender_name_2, :lender_seller_carry_back, :lender_seller_carry_back_2, 
                    :lender_state, :lender_state_2, :lender_zip, :lender_zip_2, :lender_zip_extended, :lender_zip_extended_2, 
                    :mortgage_amount, :mortgage_amount_2, :mortgage_due_date, :mortgage_due_date_2, :mortgage_interest_rate, 
                    :mortgage_interest_rate_type, :mortgage_lender_code, :mortgage_rate_2, :mortgage_recording_date, 
                    :mortgage_recording_date_2, :mortgage_term, :mortgage_term_2, :mortgage_term_type, :mortgage_term_type_2, 
                    :mortgage_type, :mortgage_type_2, :multi_parcel_flag, :name_title_company, :recording_date, :transfer_amount
            
                    def initialize(obj)
                        @code_title_company = obj['code_title_company']
                        @instrument_date = obj['instrument_date']
                        @interest_rate_type_2 = obj['interest_rate_type_2']
                        @lender_address = obj['lender_address']
                        @lender_address_2 = obj['lender_address_2']
                        @lender_city = obj['lender_city']
                        @lender_city_2 = obj['lender_city_2']
                        @lender_code_2 = obj['lender_code_2']
                        @lender_first_name = obj['lender_first_name']
                        @lender_first_name_2 = obj['lender_first_name_2']
                        @lender_last_name = obj['lender_last_name']
                        @lender_last_name_2 = obj['lender_last_name_2']
                        @lender_name = obj['lender_name']
                        @lender_name_2 = obj['lender_name_2']
                        @lender_seller_carry_back = obj['lender_seller_carry_back']
                        @lender_seller_carry_back_2 = obj['lender_seller_carry_back_2']
                        @lender_state = obj['lender_state']
                        @lender_state_2 = obj['lender_state_2']
                        @lender_zip = obj['lender_zip']
                        @lender_zip_2 = obj['lender_zip_2']
                        @lender_zip_extended = obj['lender_zip_extended']
                        @lender_zip_extended_2 = obj['lender_zip_extended_2']
                        @mortgage_amount = obj['mortgage_amount']
                        @mortgage_amount_2 = obj['mortgage_amount_2']
                        @mortgage_due_date = obj['mortgage_due_date']
                        @mortgage_due_date_2 = obj['mortgage_due_date_2']
                        @mortgage_interest_rate = obj['mortgage_interest_rate']
                        @mortgage_interest_rate_type = obj['mortgage_interest_rate_type']
                        @mortgage_lender_code = obj['mortgage_lender_code']
                        @mortgage_rate_2 = obj['mortgage_rate_2']
                        @mortgage_recording_date = obj['mortgage_recording_date']
                        @mortgage_recording_date_2 = obj['mortgage_recording_date_2']
                        @mortgage_term = obj['mortgage_term']
                        @mortgage_term_2 = obj['mortgage_term_2']
                        @mortgage_term_type = obj['mortgage_term_type']
                        @mortgage_term_type_2 = obj['mortgage_term_type_2']
                        @mortgage_type = obj['mortgage_type']
                        @mortgage_type_2 = obj['mortgage_type_2']
                        @multi_parcel_flag = obj['multi_parcel_flag']
                        @name_title_company = obj['name_title_company']
                        @recording_date = obj['recording_date']
                        @transfer_amount = obj['transfer_amount']
                    end
                end
            end
        end
    end
end