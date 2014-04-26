module RSqoot
  module Deal

    # Retrieve a list of deals based on the following parameters
    #
    # @param [String] query (Search deals by title, description, fine print, merchant name, provider, and category.)
    # @param [String] location (Limit results to a particular area. We'll resolve whatever you pass us (including an IP address) to coordinates and search near there.)
    # @param [Integer] radius (Measured in miles. Defaults to 10.)
    # @param [Integer] page (Which page of result to return. Default to 1.)
    # @param [Integer] per_page (Number of results to return at once. Defaults to 10.)
    #
    def deals(options = {})
      options = update_by_expire_time options
      if deals_not_latest?(options)
        uniq = !!options.delete(:uniq)
        @rsqoot_deals = get('deals', options, SqootDeal) || []
        @rsqoot_deals = @rsqoot_deals.deals.map(&:deal) unless @rsqoot_deals.empty?
        @rsqoot_deals = uniq_deals(@rsqoot_deals) if uniq
      end
      logger(uri: sqoot_query_uri, records: @rsqoot_deals, type: 'deals', opts: options)
      @rsqoot_deals
    end

    # Retrieve a deal by id
    #
    def deal(id, options = {})
      options = update_by_expire_time options
      if deal_not_latest?(id)
        @rsqoot_deal = get("deals/#{id}", options, SqootDeal)
        @rsqoot_deal = @rsqoot_deal.deal if @rsqoot_deal
      end
      logger(uri: sqoot_query_uri, records: [@rsqoot_deal], type: 'deal', opts: options)
      @rsqoot_deal
    end

    def impression(deal_id, options = {})
      url_generator("deals/#{deal_id}/image", options, true).first.to_s
    end

    # Auto Increment for deals query.
    def total_sqoot_deals(options = {})
      @total_deals  ||= []
      @cached_pages ||= []
      page = options[:page] || 1
      check_query_change options
      unless page_cached? page
        @total_deals += deals(options)
        @total_deals.uniq!
        @cached_pages << page.to_s
        @cached_pages.uniq!
      end
      @total_deals
    end

    private

    attr_reader :cached_pages, :total_deals, :last_deals_query

    # Uniq deals from Sqoot, because there are some many duplicated deals
    # with different ids
    # Simplely distinguish them by their titles
    #
    def uniq_deals(deals = [])
      titles = deals.map(&:title).uniq
      titles.map do |title|
        deals.map do |deal|
          deal if deal.try(:title) == title
        end.compact.last
      end.flatten
    end

    # A status checker for method :total_sqoot_deals
    # If the query parameters changed, this will reset the cache
    # else it will do nothing
    #
    def check_query_change(options = {})
      options = update_by_expire_time options
      @last_deals_query ||= ''
      current_query = options[:query].to_s
      current_query += options[:category_slugs].to_s
      current_query += options[:location].to_s
      current_query += options[:radius].to_s
      current_query += options[:online].to_s
      current_query += options[:expired_in].to_s
      current_query += options[:per_page].to_s
      if @last_deals_query != current_query
        @last_deals_query = current_query
        @total_deals  = []
        @cached_pages = []
      end
    end

    # Helper methods to detect which page is cached
    #
    def page_cached?(page = 1)
      cached_pages.include? page.to_s
    end
  end
end
