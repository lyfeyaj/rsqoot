module RSqoot
  module Commission

    # Retrieve information of commissions based on the following parameters
    #
    # @param [String] :to Start date
    # @param [String] :from End date
    #
    # @return [Hashie::Mash]
    def commissions(options={})
      updated_by options
      if commissions_not_latest?(options)
        @rsqoot_commissions = get('commissions', options)
        @rsqoot_commissions = @rsqoot_commissions.commissions if @rsqoot_commissions
      end
      @rsqoot_commissions
    end

  end
end