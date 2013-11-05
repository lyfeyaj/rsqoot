module RSqoot
  module Click

    # Retrieve a list of clicks based on the following parameters
    #
    # @param [String] :to Start date
    # @param [String] :from End date
    #
    # @return [Hashie::Mash]
    def clicks(options={})
      updated_by options
      if clicks_not_latest?(options)
        @rsqoot_clicks = get('clicks', options)
        @rsqoot_clicks = @rsqoot_clicks.clicks if @rsqoot_clicks
      end
      @rsqoot_clicks
    end

  end
end