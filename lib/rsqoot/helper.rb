require 'hashie/mash'
module RSqoot
  module Helper

    # Add auto-cache helper methods, instances to save the latest query
    #
    def self.included(base)
      [ 'deals',
        'deal',
        'categories',
        'providers',
        'merchant',
        'commissions',
        'clicks' ].each do |name|
        attr_reader ('rsqoot_' + name).to_sym
        attr_accessor (name + '_options').to_sym
        base.send :define_method, (name + '_not_latest?').to_sym do |opt|
          result = method(name + '_options').call == opt ? false : true
          method(name + '_options=').call opt if result
          result
        end
      end

      # Add categories and providers query helpers
      # Search categories and providers will be very easy
      # Such as: query_categories('home&_visiter,friends')
      # => search records like: home, visiter, friends
      #
      [ 'categories',
        'providers' ].each do |name|
        base.send :define_method, ('query_' + name).to_sym do |q|
          queries = q.downcase.scan(/[A-Za-z]+|\d+/)
          if queries.present?
            queries.map do |q|
              instance_variable_get('@rsqoot_' + name).dup.keep_if do |c|
                c.slug =~ Regexp.new(q)
              end
            end.flatten.compact.uniq
          end
        end
        base.class_eval { private ('query_' + name).to_sym }
      end

      # Add Wrappers: Deal, Category, Commission, Merchant, Provider, Click
      # All records should return as RSqoot::Sqoot* object
      #
      [ 'SqootDeal',
        'SqootCategory',
        'SqootCommission',
        'SqootMerchant',
        'SqootProvider',
        'SqootClick'].each do |class_name|
        new_class = Class.new(::Hashie::Mash)
        RSqoot.const_set class_name, new_class
      end
    end

    # Add expired time functionality to this gem
    # By default is 1.hour, and can be replaced anywhere
    #
    def update_by_expire_time(options = {})
      @expired_in = options[:expired_in] if options[:expired_in].present?
      time = Time.now.to_i / expired_in.to_i
      options.merge({expired_in: time})
    end

  end
end