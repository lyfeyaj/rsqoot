require "rsqoot/merchant"
require "rsqoot/category"
require "rsqoot/provider"
require "rsqoot/commission"
require "rsqoot/click"
require "rsqoot/deal"
require "rsqoot/request"

module RSqoot
  class Client
    include Category
    include Click
    include Commission
    include Deal
    include Merchant
    include Provider
    include Request

    attr_reader :public_api_key, :private_api_key, :base_api_url, :authentication_method, :read_timeout

    def initialize(options={})
      @public_api_key        = options[:public_api_key] || RSqoot.public_api_key
      @private_api_key       = options[:private_api_key] || RSqoot.private_api_key
      @base_api_url          = options[:base_api_url] || RSqoot.base_api_url
      @authentication_method = options[:authentication_method] || RSqoot.authentication_method
      @read_timeout          = options[:read_timeout] || RSqoot.read_timeout
    end

  end
end
