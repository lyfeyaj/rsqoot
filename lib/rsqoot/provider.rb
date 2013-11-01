module RSqoot
  module Provider
    # Retrieve a list of providers base on the following parameters
    #
    # @return [Hashie::Mash]
    def providers(options={})
      if providers_not_latest?(options)
        @rsqoot_providers = get('providers', options)
        @rsqoot_providers = @rsqoot_providers.providers if @rsqoot_providers
      end
      @rsqoot_providers
    end
  end
end