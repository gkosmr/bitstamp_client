require 'observer'

module BitstampClient
  module Requests
    class Base

      include Observable

      attr_reader :config, :type, :endpoint_name, :url

      def initialize(config, type)
        @config = config
        @type = type
      end

      def self.build(config, type)
        type = self.type(type)

        "BitstampClient::Requests::#{type}".constantize.new(config, type)
      end

      def call(url, _endpoint_name, _options = nil)
        changed
      end

      def self.type(given_type)
        given_type == 'Public' ? 'Get' : 'Post'
      end
    end
  end
end
