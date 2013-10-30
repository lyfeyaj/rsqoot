module RSqoot
  module Category

    # Retrieve a list of categories base on the following parameters
    #
    # @return [Hashie::Mash] category list
    def categories(options={})
      get('categories', options)
    end
  end
end