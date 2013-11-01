module RSqoot
  module Category

    # Retrieve a list of categories base on the following parameters
    #
    # @return [Hashie::Mash] category list
    def categories(options={})
      if categories_not_latest?(options)
        @rsqoot_categories = get('categories', options)
        @rsqoot_categories = @rsqoot_categories.categories if @rsqoot_categories
      end
      @rsqoot_categories
    end
  end
end