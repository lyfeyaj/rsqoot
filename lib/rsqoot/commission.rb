module RSqoot
  module Commission

    # Retrieve information of commissions based on the following parameters
    #
    # @param [String] :to Start date
    # @param [String] :from End date
    #
    # @return [RSqoot::SqootCommission]
    def commissions(options={})
      options = update_by_expire_time options
      if commissions_not_latest?(options)
        @rsqoot_commissions = get('commissions', options, SqootCommission)
        @rsqoot_commissions = @rsqoot_commissions.commissions if @rsqoot_commissions
      end
      @rsqoot_commissions
    end

  end
end