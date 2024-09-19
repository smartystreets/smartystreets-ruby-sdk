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
require_relative "lookup"
require_relative '../request'

module SmartyStreets
    module USEnrichment
        class Client
            def initialize(sender, serializer)
                @sender = sender
                @serializer = serializer
            end

            def send_property_financial_lookup(lookup)
                if (lookup.instance_of? String)
                    __send(USEnrichment::Property::Financial::Lookup.new(lookup))
                elsif (lookup.instance_of? USEnrichment::Lookup)
                    lookup.data_set = 'property'
                    lookup.data_sub_set = 'financial'
                    __send(lookup)
                end
            end

            def send_property_principal_lookup(lookup)
                if (lookup.instance_of? String)
                    __send(USEnrichment::Property::Principal::Lookup.new(lookup))
                elsif (lookup.instance_of? USEnrichment::Lookup)
                    lookup.data_set = 'property'
                    lookup.data_sub_set = 'principal'
                    __send(lookup)
                end
            end

            def send_geo_reference_lookup(lookup)
                if (lookup.instance_of? String)
                    __send(USEnrichment::GeoReference::Lookup.new(lookup))
                elsif (lookup.instance_of? USEnrichment::Lookup)
                    lookup.data_set = 'geo-reference'
                    lookup.data_sub_set = nil
                    __send(lookup)
                end
            end

            def send_secondary_lookup(lookup)
                if (lookup.instance_of? String)
                    __send(USEnrichment::Secondary::Lookup.new(lookup))
                elsif (lookup.instance_of? USEnrichment::Lookup)
                    lookup.data_set = 'secondary'
                    lookup.data_sub_set = nil
                    __send(lookup)
                end
            end

            def send_secondary_count_lookup(lookup)
                if (lookup.instance_of? String)
                    __send(USEnrichment::Secondary::Count::Lookup.new(lookup))
                elsif (lookup.instance_of? USEnrichment::Lookup)
                    lookup.data_set = 'secondary'
                    lookup.data_sub_set = 'count'
                    __send(lookup)
                end
            end

            def send_generic_lookup(lookup, data_set, data_sub_set = nil)
                if (lookup.instance_of? String)
                    __send(USEnrichment::Lookup.new(lookup, data_set, data_sub_set))
                elsif (lookup.instance_of? USEnrichment::Lookup)
                    lookup.data_set = data_set
                    lookup.data_sub_set = data_sub_set
                    __send(lookup)
                end
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
                __send(USEnrichment::Lookup.new(smarty_key, data_set, data_sub_set))
            end

            def __send(lookup)
                smarty_request = Request.new

                return if lookup.nil?
<<<<<<< HEAD
                if (lookup.smarty_key.nil?)
                    if (lookup.data_sub_set.nil?)
                        smarty_request.url_components = '/search/' + lookup.data_set
                    else
                        smarty_request.url_components = '/search/' + lookup.data_set + '/' + lookup.data_sub_set
                    end
                    add_parameter(smarty_request, 'freeform', lookup.freeform)
                    add_parameter(smarty_request, 'street', lookup.street)
                    add_parameter(smarty_request, 'city', lookup.city)
                    add_parameter(smarty_request, 'state', lookup.state)
                    add_parameter(smarty_request, 'zipcode', lookup.zipcode)
                else
                    if (lookup.data_sub_set.nil?)
                        smarty_request.url_components = '/' + lookup.smarty_key + '/' + lookup.data_set
                    else
                        smarty_request.url_components = '/' + lookup.smarty_key + '/' + lookup.data_set + '/' + lookup.data_sub_set
                    end
                end
                
=======

                if (lookup.data_sub_set.nil?)
                    smarty_request.url_components = '/' + lookup.smarty_key + '/' + lookup.data_set
                else
                    smarty_request.url_components = '/' + lookup.smarty_key + '/' + lookup.data_set + '/' + lookup.data_sub_set
                end
>>>>>>> 48dda29c9382c5cd28b751e3595b772f6427acc8

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

            def add_parameter(request, key, value)
                request.parameters[key] = value unless value.nil? or value.empty?
            end
        end
    end
end