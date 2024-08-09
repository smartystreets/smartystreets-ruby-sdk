require_relative "property/financial/response"
require_relative "property/principal/response"
require_relative "property/financial/lookup"
require_relative "property/principal/lookup"
require_relative "geo_reference/response"
require_relative "geo_reference/lookup"
require_relative "secondary/response"
require_relative "secondary/lookup"
require_relative "secondary/count/response"
require_relative "secondary/count/lookup"
require_relative '../request'

module SmartyStreets
    module USEnrichment
        class Client
            def initialize(sender, serializer)
                @sender = sender
                @serializer = serializer
            end

            def send_property_financial_lookup(smarty_key)
                __send(USEnrichment::Property::Financial::Lookup.new(smarty_key))
            end

            def send_property_principal_lookup(smarty_key)
                __send(USEnrichment::Property::Principal::Lookup.new(smarty_key))
            end

            def send_geo_reference_lookup(smarty_key)
                __send(USEnrichment::GeoReference::Lookup.new(smarty_key))
            end

            def send_secondary_lookup(smarty_key)
                __send(USEnrichment::Secondary::Lookup.new(smarty_key))
            end

            def send_secondary_count_lookup(smarty_key)
                __send(USEnrichment::Secondary::Count::Lookup.new(smarty_key))
            end

            def send_generic_lookup(smarty_key, data_set, data_sub_set = nil)
                if data_sub_set == "financial"
                    return __send(USEnrichment::Property::Financial::Lookup.new(smarty_key))
                end
                if data_sub_set == "principal"
                    puts(smarty_key)
                    return __send(USEnrichment::Property::Principal::Lookup.new(smarty_key))
                end
                if data_set == "geo-reference"
                    return __send(USEnrichment::GeoReference::Lookup.new(smarty_key))
                end
                if data_set == "secondary"
                    if data_sub_set == "count"
                        return __send(USEnrichment::Secondary::Count::Lookup.new(smarty_key))
                    elsif data_sub_set.nil?
                        return __send(USEnrichment::Secondary::Lookup.new(smarty_key))
                    end
                end
            end

            def __send(lookup)
                smarty_request = Request.new

                return if lookup.nil?

                if (lookup.data_sub_set.nil?)
                    smarty_request.url_components = '/' + lookup.smarty_key + '/' + lookup.data_set
                else
                    smarty_request.url_components = '/' + lookup.smarty_key + '/' + lookup.data_set + '/' + lookup.data_sub_set
                end

                response = @sender.send(smarty_request)
                results = @serializer.deserialize(response.payload)
                
                results = [] if results.nil?
                raise response.error if response.error
                
                output = []
                results.each do |raw_result|
                    result = nil
                    if lookup.data_sub_set == "financial"
                        result = USEnrichment::Property::Financial::Response.new(raw_result)
                    end
                    if lookup.data_sub_set == "principal"
                        result = USEnrichment::Property::Principal::Response.new(raw_result)
                    end
                    if lookup.data_set == "geo-reference"
                      result = USEnrichment::GeoReference::Response.new(raw_result)
                    end
                    if lookup.data_set == "secondary"
                      if lookup.data_sub_set == "count"
                        result = USEnrichment::Secondary::Count::Response.new(raw_result)
                      elsif lookup.data_sub_set.nil?
                        result = USEnrichment::Secondary::Response.new(raw_result)
                      end
                    end
                    output << result
                end
                output
            end
        end
    end
end