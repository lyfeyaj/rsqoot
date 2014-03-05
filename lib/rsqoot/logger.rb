module RSqoot
  module Logger

    # Add logger support, easy for log monitor when running your app
    # Output errors and valid records count
    # TODO add color support
    #
    def logger(options = {records: [], uri: '', error: '', type: '', opts: {}})
      records = options[:records].nil? ? [] : options[:records]
      error   = options[:error]
      uri     = options[:uri]
      type    = options[:type]
      opts    = options[:opts]

      if defined? Rails
        if error.present?
          Rails.logger.info ">>> Error: #{error}"
        else
          Rails.logger.info ">>> Querying Sqoot API V2: #{type}"
          Rails.logger.info ">>> #{uri}"
          Rails.logger.info ">>> #{opts}"
          Rails.logger.info ">>> Hit #{records.count} records"
        end
      else
        if error.present?
          puts ">>> Error: #{error}"
          puts ""
        else
          puts ">>> Querying Sqoot API V2: #{type}"
          puts ""
          puts ">>> #{uri}"
          puts ""
          puts ">>> #{opts}"
          puts ""
          puts ">>> Hit #{records.count} records"
          puts ""
        end
      end
    end

    module_function :logger
  end
end