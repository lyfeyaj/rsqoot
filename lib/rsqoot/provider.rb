module RSqoot
  module Provider
    # Retrieve a list of providers base on the following parameters
    #
    # @return [Hashie::Mash]
    def providers(options={})
      options = update_by_expire_time options
      query = options.delete(:query)
      if providers_not_latest?(options)
        @rsqoot_providers = get('providers', options)
        @rsqoot_providers = @rsqoot_providers.providers.map(&:provider) if @rsqoot_providers
      end
      query.present? ? query_providers(query) : @rsqoot_providers
    end

  end
end