module RSqoot
  module Helper
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
    end
  end
end