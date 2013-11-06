module RSqoot
  module Merchant

    # Retrieve a list of merchants base on the following parameters
    #
    # @param [String] id (The merchant's ID, Use the Sqoot ID or ID for any supported namespace. Must supply namespace if we don't use Sqoot)
    # @param [String] namespace (One of the supported namespaces. Factual, Foursquare, Facebook, Google, CitySearch, Yelp.)

    def merchant(id, options={})
      options = update_by_expire_time options
      if merchant_not_latest?(id)
        @rsqoot_merchant = get("merchants/#{id}", options)
        @rsqoot_merchant = @rsqoot_merchant.merchant if @rsqoot_merchant
      end
      @rsqoot_merchant
    end

  end
end