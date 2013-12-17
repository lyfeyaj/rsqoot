require 'open-uri'
require 'json'

module RSqoot
  module Request

    # Get method, use by all other API qeury methods, fetch records
    # from the Sqoot API V2 url, and provide wrapper functionality
    #
    def get(path, opts = {}, wrapper = ::Hashie::Mash)
      uri, headers = url_generator(path, opts)
      begin
        json = JSON.parse uri.open(headers).read
        result = wrapper.new json
        @query_options = result.query
        result
      rescue => e
        logger({error: e})
        nil
      end
    end

    # Generate valid Sqoot API V2 url and provide two different way of
    # authentication: :header, :parameter
    #
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
      @sqoot_query_uri = uri
      [uri, headers]
    end

    private

    # Endpoints that needs private key
    #
    def private_endpoints
      %w(clicks commissions)
    end

    # Endpoints that both public or private key will work
    #
    def public_endpoints
      %w(categories deals merchants providers)
    end

    # Decide which api key should be used: private, public
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