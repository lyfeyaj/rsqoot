module RSqoot
  module Provider
    # Retrieve a list of providers base on the following parameters
    #
    # @return [Hashie::Mash]
    def providers(options={})
      get('providers', options)
    end
  end
end