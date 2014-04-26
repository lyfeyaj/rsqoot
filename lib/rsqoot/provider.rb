module RSqoot
  module Provider
    # Retrieve a list of providers base on the following parameters
    #
    # @return [RSqoot::SqootProvider]
    def providers(options = {})
      options = update_by_expire_time options
      query = options.delete(:query)
      if providers_not_latest?(options)
        @rsqoot_providers = get('providers', options, SqootProvider)
        @rsqoot_providers = @rsqoot_providers.providers.map(&:provider) if @rsqoot_providers
      end
      result = query.present? ? query_providers(query) : @rsqoot_providers
      logger(uri: sqoot_query_uri, records: result, type: 'providers', opts: options)
      result
    end
  end
end
