require 'singleton'
require 'rsqoot/helper'
require 'rsqoot/merchant'
require 'rsqoot/category'
require 'rsqoot/provider'
require 'rsqoot/commission'
require 'rsqoot/click'
require 'rsqoot/deal'
require 'rsqoot/request'
require 'rsqoot/logger'

module RSqoot
  class Client
    include Singleton
    include Helper
    include Category
    include Click
    include Commission
    include Deal
    include Merchant
    include Provider
    include Request
    include Logger

    attr_reader :public_api_key,
                :private_api_key,
                :base_api_url,
                :authentication_method,
                :read_timeout,
                :query_options,
                :expired_in,
                :sqoot_query_uri

    def initialize(options = {})
      @public_api_key        = options[:public_api_key]        || RSqoot.public_api_key
      @private_api_key       = options[:private_api_key]       || RSqoot.private_api_key
      @base_api_url          = options[:base_api_url]          || RSqoot.base_api_url
      @authentication_method = options[:authentication_method] || RSqoot.authentication_method
      @read_timeout          = options[:read_timeout]          || RSqoot.read_timeout
      @expired_in            = options[:expired_in]            || RSqoot.expired_in
    end

    def reload!(options = {})
      initialize(options)
      self.class.instance
    end
  end
end
