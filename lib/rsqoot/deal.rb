module RSqoot
  module Deal

    # Retrieve a list of deals based on the following parameters
    #
    # @param [String] query (Search deals by title, description, fine print, merchant name, provider, and category.)
    # @param [String] location (Limit results to a particular area. We'll resolve whatever you pass us (including an IP address) to coordinates and search near there.)
    # @param [Integer] radius (Measured in miles. Defaults to 10.)
    # @param [Integer] page (Which page of result to return. Default to 1.)
    # @param [Integer] per_page (Number of results to return at once. Defaults to 10.)
    def deals(options={})
      get('deals', options)
    end

    # Retrieve a deal by id
    #
    def deal(id, options={})
      get("deals/#{id}", options)
    end

    def deal_click(id, options={})
      get("deals/#{id}/click", options, parse = false)
    end

    def deal_impression(id, options={})
      get("deals/#{id}/image", options, parse = false)
    end

  end
end