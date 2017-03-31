module BitstampClient
  module Requests
    class Post < Base

      def call(url, options)
        super
        @url = url
        HTTParty.post(url, params(options)).parsed_response
      end

      private

      def params(options = {})
        {
          body: content_manager::Body.new(config, options, url).call 
        }
      end

      def content_manager
        BitstampClient::Requests::Content
      end

    end
  end
end
