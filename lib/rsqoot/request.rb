require 'open-uri'
require 'hashie/mash'
require 'json'

module RSqoot
  module Request

    def get(path, opts = {})
      uri, headers = url_generator(path, opts)
      begin
        json = JSON.parse uri.open(headers).read
        result = ::Hashie::Mash.new json
        @query_options = result.query
        result
      rescue
        nil
      end
    end

    def url_generator(path, opts = {}, require_key = false)
      uri      = URI.parse base_api_url
      headers  = {read_timeout: read_timeout}
      uri.path = '/v2/' + path
      query    = options_parser opts
      endpoint = path.split('/')[0]
      case authentication_method
      when :header
        headers.merge! h = {"Authorization" => "api_key #{api_key(endpoint)}"}
        query = query + "&api_key=#{api_key(endpoint)}" if require_key
      when :parameter
        query = query + "&api_key=#{api_key(endpoint)}"
      end
      uri.query = query
      [uri, headers]
    end

    private

    def private_endpoints
      %w(clicks commissions)
    end

    def public_endpoints
      %w(categories deals merchants providers)
    end

    def api_key(endpoint='')
      if private_endpoints.include? endpoint
        private_api_key
      elsif public_endpoints.include? endpoint
        public_api_key
      else
        raise "No such endpoint #{endpoint} available."
      end
    end

    # Example: options = {per_page: 10, page: 1}
    # Options should be parsed as http query: per_page=10&page=1
    #
    # @return [String]
    def options_parser(options = {})
      query = options.map do |key, value|
        [key, value].map(&:to_s).join('=')
      end.join('&')
      URI.encode query
    end

  end
end