require_relative "property/principal/response"
require_relative "geo_reference/response"
require_relative "risk/response"
require_relative "secondary/response"
require_relative "secondary/count/response"
require_relative "lookup"
require_relative '../request'

module SmartyStreets
    module USEnrichment
        class Client
            def initialize(sender, serializer)
                @sender = sender
                @serializer = serializer
            end

            def send_property_principal_lookup(lookup)
                send_property_principal_lookup_with_auth(lookup, nil, nil)
            end

            # Sends a property principal lookup with per-request credentials.
            # If auth_id and auth_token are both non-empty, they will be used for this request instead of the client-level credentials.
            # This is useful for multi-tenant scenarios where different requests require different credentials.
            def send_property_principal_lookup_with_auth(lookup, auth_id, auth_token)
                if (lookup.instance_of? String)
                    __send_with_auth(USEnrichment::Lookup.new(lookup,'property','principal'), auth_id, auth_token)
                elsif (lookup.instance_of? USEnrichment::Lookup)
                    lookup.data_set = 'property'
                    lookup.data_sub_set = 'principal'
                    __send_with_auth(lookup, auth_id, auth_token)
                end
            end

            def send_geo_reference_lookup(lookup)
                send_geo_reference_lookup_with_auth(lookup, nil, nil)
            end

            # Sends a geo reference lookup with per-request credentials.
            # If auth_id and auth_token are both non-empty, they will be used for this request instead of the client-level credentials.
            # This is useful for multi-tenant scenarios where different requests require different credentials.
            def send_geo_reference_lookup_with_auth(lookup, auth_id, auth_token)
                if (lookup.instance_of? String)
                    __send_with_auth(USEnrichment::Lookup.new(lookup,'geo-reference'), auth_id, auth_token)
                elsif (lookup.instance_of? USEnrichment::Lookup)
                    lookup.data_set = 'geo-reference'
                    lookup.data_sub_set = nil
                    __send_with_auth(lookup, auth_id, auth_token)
                end
            end

            def send_risk_lookup(lookup)
                send_risk_lookup_with_auth(lookup, nil, nil)
            end

            # Sends a risk lookup with per-request credentials.
            # If auth_id and auth_token are both non-empty, they will be used for this request instead of the client-level credentials.
            # This is useful for multi-tenant scenarios where different requests require different credentials.
            def send_risk_lookup_with_auth(lookup, auth_id, auth_token)
                if (lookup.instance_of? String)
                    __send_with_auth(USEnrichment::Lookup.new(lookup,'risk'), auth_id, auth_token)
                elsif (lookup.instance_of? USEnrichment::Lookup)
                    lookup.data_set = 'risk'
                    lookup.data_sub_set = nil
                    __send_with_auth(lookup, auth_id, auth_token)
                end
            end

            def send_secondary_lookup(lookup)
                send_secondary_lookup_with_auth(lookup, nil, nil)
            end

            # Sends a secondary lookup with per-request credentials.
            # If auth_id and auth_token are both non-empty, they will be used for this request instead of the client-level credentials.
            # This is useful for multi-tenant scenarios where different requests require different credentials.
            def send_secondary_lookup_with_auth(lookup, auth_id, auth_token)
                if (lookup.instance_of? String)
                    __send_with_auth(USEnrichment::Lookup.new(lookup,'secondary'), auth_id, auth_token)
                elsif (lookup.instance_of? USEnrichment::Lookup)
                    lookup.data_set = 'secondary'
                    lookup.data_sub_set = nil
                    __send_with_auth(lookup, auth_id, auth_token)
                end
            end

            def send_secondary_count_lookup(lookup)
                send_secondary_count_lookup_with_auth(lookup, nil, nil)
            end

            # Sends a secondary count lookup with per-request credentials.
            # If auth_id and auth_token are both non-empty, they will be used for this request instead of the client-level credentials.
            # This is useful for multi-tenant scenarios where different requests require different credentials.
            def send_secondary_count_lookup_with_auth(lookup, auth_id, auth_token)
                if (lookup.instance_of? String)
                    __send_with_auth(USEnrichment::Lookup.new(lookup,'secondary','count'), auth_id, auth_token)
                elsif (lookup.instance_of? USEnrichment::Lookup)
                    lookup.data_set = 'secondary'
                    lookup.data_sub_set = 'count'
                    __send_with_auth(lookup, auth_id, auth_token)
                end
            end

            def send_generic_lookup(lookup, data_set, data_sub_set = nil)
                send_generic_lookup_with_auth(lookup, data_set, data_sub_set, nil, nil)
            end

            # Sends a generic lookup with per-request credentials.
            # If auth_id and auth_token are both non-empty, they will be used for this request instead of the client-level credentials.
            # This is useful for multi-tenant scenarios where different requests require different credentials.
            def send_generic_lookup_with_auth(lookup, data_set, data_sub_set, auth_id, auth_token)
                if (lookup.instance_of? String)
                    __send_with_auth(USEnrichment::Lookup.new(lookup, data_set, data_sub_set), auth_id, auth_token)
                elsif (lookup.instance_of? USEnrichment::Lookup)
                    lookup.data_set = data_set
                    lookup.data_sub_set = data_sub_set
                    __send_with_auth(lookup, auth_id, auth_token)
                end
            end

            def __send(lookup)
                __send_with_auth(lookup, nil, nil)
            end

            def __send_with_auth(lookup, auth_id, auth_token)
                smarty_request = Request.new

                return if lookup.nil?

                if (!lookup.etag.nil?)
                    smarty_request.header["ETAG"] = lookup.etag
                end

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
                for key in lookup.custom_param_hash.keys do
                    add_parameter(smarty_request, key, lookup.custom_param_hash[key])
                end

                if !auth_id.nil? && !auth_id.empty? && !auth_token.nil? && !auth_token.empty?
                    smarty_request.auth_id = auth_id
                    smarty_request.auth_token = auth_token
                end

                response = @sender.send(smarty_request)
                results = @serializer.deserialize(response.payload)

                results = [] if results.nil?
                raise response.error if response.error

                output = []
                results.each do |raw_result|
                    result = nil
                    if lookup.data_sub_set == "principal"
                        result = USEnrichment::Property::Principal::Response.new(raw_result, response.header['etag'])
                    end
                    if lookup.data_set == "geo-reference"
                      result = USEnrichment::GeoReference::Response.new(raw_result, response.header['etag'])
                    end
                    if lookup.data_set == "risk"
                      result = USEnrichment::Risk::Response.new(raw_result, response.header['etag'])
                    end
                    if lookup.data_set == "secondary"
                      if lookup.data_sub_set == "count"
                        result = USEnrichment::Secondary::Count::Response.new(raw_result, response.header['etag'])
                      elsif lookup.data_sub_set.nil?
                        result = USEnrichment::Secondary::Response.new(raw_result, response.header['etag'])
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