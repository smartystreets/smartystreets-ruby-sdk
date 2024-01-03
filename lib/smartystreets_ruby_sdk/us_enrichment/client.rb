require_relative "property/financial/response"
require_relative "property/principal/response"
require_relative "property/financial/lookup"
require_relative "property/principal/lookup"
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

            def __send(lookup)
                smarty_request = Request.new

                return if lookup.nil?

                smarty_request.url_prefix = '/' + lookup.smarty_key + '/' + lookup.data_set + '/' + lookup.data_sub_set

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
                    output << result
                end
                output
            end
        end
    end
end