module BitstampClient
  module Endpoints
    class Public < Base

      def perform(endpoint_name, version, args)
        response = request_manager.call(url(endpoint_name, version, args.delete(:pair)), args)
        Hashie::Mash.new(JSON.parse(response.body))
      end

      def v2_endpoints
        {
          :ticker       => [:ticker, params: [:pair]],
          :ticker_hour  => [:ticker_hour, params: [:pair]],
          :order_book   => [:order_book, params: [:pair]],
          :transactions => [:transactions, params: [:pair]]
        }
      end

      def endpoints
        {

        }
      end
    end
  end
end
