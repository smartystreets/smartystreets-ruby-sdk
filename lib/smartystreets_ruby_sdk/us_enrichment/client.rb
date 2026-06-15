require_relative "property/principal/response"
require_relative "geo_reference/response"
require_relative "secondary/response"
require_relative "secondary/count/response"
require_relative "business/summary/response"
require_relative "business/detail/response"
require_relative "lookup"
require_relative '../request'
require_relative '../exceptions'
require 'uri'

module SmartyStreets
    module USEnrichment
        class Client
            def initialize(sender, serializer)
                @sender = sender
                @serializer = serializer
            end

            def send_property_principal_lookup(lookup)
                if (lookup.instance_of? String)
                    __send(USEnrichment::Lookup.new(lookup,'property','principal'))
                elsif (lookup.instance_of? USEnrichment::Lookup)
                    lookup.data_set = 'property'
                    lookup.data_sub_set = 'principal'
                    __send(lookup)
                end
            end

            def send_geo_reference_lookup(lookup)
                if (lookup.instance_of? String)
                    __send(USEnrichment::Lookup.new(lookup,'geo-reference'))
                elsif (lookup.instance_of? USEnrichment::Lookup)
                    lookup.data_set = 'geo-reference'
                    lookup.data_sub_set = nil
                    __send(lookup)
                end
            end

            def send_secondary_lookup(lookup)
                if (lookup.instance_of? String)
                    __send(USEnrichment::Lookup.new(lookup,'secondary'))
                elsif (lookup.instance_of? USEnrichment::Lookup)
                    lookup.data_set = 'secondary'
                    lookup.data_sub_set = nil
                    __send(lookup)
                end
            end

            def send_secondary_count_lookup(lookup)
                if (lookup.instance_of? String)
                    __send(USEnrichment::Lookup.new(lookup,'secondary','count'))
                elsif (lookup.instance_of? USEnrichment::Lookup)
                    lookup.data_set = 'secondary'
                    lookup.data_sub_set = 'count'
                    __send(lookup)
                end
            end

            def send_business_lookup(lookup)
                if (lookup.instance_of? String)
                    __send(USEnrichment::Lookup.new(lookup,'business'))
                elsif (lookup.instance_of? USEnrichment::Lookup)
                    lookup.data_set = 'business'
                    lookup.data_sub_set = nil
                    __send(lookup)
                end
            end

            def send_business_detail_lookup(lookup)
                if (lookup.instance_of? String)
                    lookup = USEnrichment::BusinessDetailLookup.new(lookup)
                end
                unless lookup.instance_of? USEnrichment::BusinessDetailLookup
                    raise SmartyError.new("Business detail lookup requires a non-empty 'business_id'")
                end
                if blank?(lookup.business_id)
                    raise SmartyError.new("Business detail lookup requires a non-empty 'business_id'")
                end

                smarty_request = Request.new
                smarty_request.url_components = '/business/' + encode_path_segment(lookup.business_id)
                apply_common_request_fields(smarty_request, lookup)

                response = @sender.send(smarty_request)
                capture_response_etag(response, lookup)
                return lookup.result if response.status_code.to_s == '304'
                results = @serializer.deserialize(response.payload)

                results = [] if results.nil?
                raise response.error if response.error

                if results.length > 1
                    raise SmartyError.new("Business detail response contained #{results.length} results; expected at most 1")
                end

                if results.empty?
                    lookup.result = nil
                else
                    lookup.result = USEnrichment::Business::Detail::Response.new(results[0])
                end
                lookup.result
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

            private

            def __send(lookup)
                if lookup.nil? || (blank?(lookup.smarty_key) && blank?(lookup.street) && blank?(lookup.freeform))
                    raise SmartyError.new("Lookup requires one of 'smartykey', 'street', or 'freeform' to be set")
                end

                smarty_request = Request.new

                if (!lookup.features.nil?)
                    add_parameter(smarty_request, 'features', lookup.features)
                end

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

                apply_common_request_fields(smarty_request, lookup)

                response = @sender.send(smarty_request)
                capture_response_etag(response, lookup)
                return [] if response.status_code.to_s == '304'
                results = @serializer.deserialize(response.payload)

                results = [] if results.nil?
                raise response.error if response.error

                output = []
                results.each do |raw_result|
                    result = nil
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
                    if lookup.data_set == "business" && lookup.data_sub_set.nil?
                        result = USEnrichment::Business::Summary::Response.new(raw_result)
                    end
                    output << result
                end
                output
            end

            def apply_common_request_fields(request, lookup)
                unless lookup.include_array.empty?
                    request.parameters['include'] = lookup.include_array.join(',')
                end
                unless lookup.exclude_array.empty?
                    request.parameters['exclude'] = lookup.exclude_array.join(',')
                end
                unless lookup.request_etag.nil?
                    request.header['Etag'] = lookup.request_etag
                end
                lookup.custom_param_hash.each do |key, value|
                    add_parameter(request, key, value)
                end
            end

            def capture_response_etag(response, lookup)
                return if response.nil?
                etag = response.find_header('etag')
                lookup.response_etag = etag unless etag.nil?
            end

            def encode_path_segment(value)
                URI.encode_www_form_component(value).gsub('+', '%20')
            end

            def add_parameter(request, key, value)
                request.parameters[key] = value unless value.nil? or value.empty?
            end

            def blank?(value)
                value.nil? || value.to_s.strip.empty?
            end
        end
    end
end
