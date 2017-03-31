module BitstampClient
  module Requests
    class Post < Base

      def call(url, endpoint_name, options)
        super

        @url           = url
        @endpoint_name = endpoint_name

        response       = HTTParty.post(url, params(options)).parsed_response
        response['error'].empty? ? response['result'] : response['error']
      end

      private

      def params(options = {})
        { body: content_manager::Body.new(config, endpoint_name, options, url).call }
      end

      def content_manager
        BitstampClient::Requests::Content
      end

    end
  end
end
