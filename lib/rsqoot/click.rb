module RSqoot
  module Click

    # Retrieve a list of clicks based on the following parameters
    #
    # @param [String] :to Start date
    # @param [String] :from End date
    #
    # @return [RSqoot::SqootClick]
    def clicks(options={})
      options = update_by_expire_time options
      if clicks_not_latest?(options)
        @rsqoot_clicks = get('clicks', options, SqootClick)
        @rsqoot_clicks = @rsqoot_clicks.clicks if @rsqoot_clicks
      end
      logger({uri: sqoot_query_uri, records: @rsqoot_clicks, type: 'clicks', opts: options})
      @rsqoot_clicks
    end

  end
end