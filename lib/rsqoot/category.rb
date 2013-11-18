module RSqoot
  module Category

    # Retrieve a list of categories base on the following parameters
    #
    # @return [RSqoot::SqootCategory] category list
    def categories(options={})
      options = update_by_expire_time options
      query = options.delete(:query)
      if categories_not_latest?(options)
        @rsqoot_categories = get('categories', options, SqootCategory)
        @rsqoot_categories = @rsqoot_categories.categories.map(&:category) if @rsqoot_categories
      end
      result = query.present? ? query_categories(query) : @rsqoot_categories
      logger({uri: sqoot_query_uri, records: result, type: 'categories', opts: options})
      result
    end

  end
end