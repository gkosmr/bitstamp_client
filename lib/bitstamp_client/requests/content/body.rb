module BitstampClient
  module Requests
    module Content
      class Body

        attr_accessor :config, :options, :url

        def initialize(config, options, url)
          @config          = config
          @url             = url

          @options         = options
          @options['nonce'] = nonce
        end

        def call
          puts options['nonce'].inspect
          {
            'key' => config.api_key,
            'signature' => signature
          }.merge(options)
        end

        private

        ## Security

        # Generate a 64-bit nonce where the 48 high bits come directly from the current
        # timestamp and the low 16 bits are pseudorandom. We can't use a pure [P]RNG here
        # because the Kraken API requires every request within a given session to use a
        # monotonically increasing nonce value. This approach splits the difference.
        def nonce
          high_bits = (Time.now.to_f * 1000 * 10000).to_i << 16 # Time.now.to_f is in seconds
          low_bits  = SecureRandom.random_number(2 ** 16) & 0xffff
          (high_bits | low_bits).to_s
        end

        def signature
          OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), config.api_secret, options['nonce'] + config.customer_id.to_s + config.api_key).upcase
        end
      end
    end
  end
end
