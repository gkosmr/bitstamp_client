module BitstampClient
  module Endpoints
    class Base

      attr_accessor :config, :options

      def initialize(config, options = {})
        @config  = config
        @options = options

        set_methods
      end

      def request_manager
        @request_manager ||= BitstampClient::Requests::Base.build(config, type)
      end

      private

      def set_methods
        [[v2_endpoints, '/v2'], [endpoints, '']].each do |(data, version)|
          data.each do |method, method_alias|
            self.class.send(:define_method, Array(method_alias).first) do |args = {}|
              raise_exception(Array(method_alias).last, args)

              perform(method.to_s, version, args)
            end
          end
        end
      end

      def type
        @type ||= self.class.name.demodulize
      end

      # "old" endpoints
      def endpoints
        fail ::BitstampClient::NotImplemented
      end

      def v2_endpoints
        fail ::BitstampClient::NotImplemented
      end

      def url(endpoint_name, version, pair)
        [config.base_uri, version, endpoint_name, pair].reject{ |part| part.nil? || part == "" }.join('/') + '/'
      end

      def raise_exception(options, args)
        return unless options.is_a?(Hash)

        leftover = options[:params] - args.keys

        if leftover.length > 0
          fail ::BitstampClient::ArgumentError, "Required options absent. Input must include #{leftover}"
        end
      end
    end
  end
end
