module RSqoot
  module Logger
    def logger(options = {records: [], uri: '', error: ''})
      records = options[:records]
      error   = options[:error]
      uri   = options[:uri]
      type = case true
      when !!(uri =~ /deals/)
        'type'
      when !!(uri =~ /categories/)
        'categories'
      when !!(uri =~ /commissions/)
        'commissions'
      when !!(uri =~ /clicks/)
        'clicks'
      when !!(uri =~ /providers/)
        'providers'
      when !!(uri =~ /merchants/)
        'merchants'
      end

      if defined? Rails
        Rails.logger.info ">>> Querying Sqoot #{type}"
        Rails.logger.info ">>> #{uri}"
        Rails.logger.info ">>> Hit #{records.count} records"
        Rails.logger.info ">>> Hit #{records.count} records" if error.present?
      else
        puts ">>> Querying Sqoot #{type}"
        puts ""
        puts ">>> #{uri}"
        puts ""
        puts ">>> Hit #{records.count} records"
        puts ""
        if error.present?
          puts ">>> Error: #{error}"
          puts ""
        end
      end
    end
  end
end