module RSqoot
  module Commission

    # Retrieve information of commissions based on the following parameters
    #
    # @param [String] :to Start date
    # @param [String] :from End date
    #
    # @return [Hashie::Mash]
    def commissions(options={})
      get('commissions', options).commissions
    end

  end
end