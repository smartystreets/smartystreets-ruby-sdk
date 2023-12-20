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

            def sendPropertyFinancialLookup(smarty_key)
                __send__(Financial.lookup.new(smarty_key))
            end

            def sendPropertyPrincipalLookup(smarty_key)
                __send__(Principal.lookup.new(smarty_key))
            end

            def __send__(lookup)
                smarty_request = Request.new

                return if lookup.nil?

                smarty_request.url_prefix = '/' + lookup.smarty_key + '/' + lookup.data_set + '/' + lookup.data_sub_set

                response = @sender.send(smarty_request)
                results = @serializer.deserialize(response.payload)
                results = [] if results.nil?
                
                output = []
                results.each do |raw_result|
                    result = nil
                    if lookup.data_sub_set == "financial"
                        result = Financial.Response.new(raw_result)
                    end
                    if lookup.data_sub_set == "principal"
                        result = Principal.Response.new(raw_result)
                    end
                    output << result
                end
                output
            end
        end
    end
end