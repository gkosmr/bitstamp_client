module BitstampClient
  module Configurable

    def config
      @config ||= ::BitstampClient::Configuration.new
    end

    def configure
      yield config if block_given?
    end

  end
end
