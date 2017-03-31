require 'active_support/inflector'
require 'base64'
require 'securerandom'
require 'addressabler'
require 'httparty'
require 'hashie'

module BitstampClient
  class Application

    def initialize(params)
      set_config(params)
    end

    def public(options = {})
      ::BitstampClient::Endpoints::Public.new(config, options)
    end

    def private(options = {})
      requires_api_keys

      ::BitstampClient::Endpoints::Private.new(config, options)
    end

    def config
      @config ||= ::BitstampClient.config.dup
    end

    private

    def requires_api_keys
      return unless api_keys_missing?

      fail BitstampClient::MissingApiKeys, 'This feature requires API credentials.'
    end

    def api_keys_missing?
      !(config.api_key && config.api_secret)
    end

    def set_config(params)
      params.each { |k, v| config.send("#{k}=", v) }
    end
  end
end
