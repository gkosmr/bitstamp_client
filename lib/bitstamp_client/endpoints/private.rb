module BitstampClient
  module Endpoints
    class Private < Base

      def perform(endpoint_name, version, args)
        result   = request_manager.call(url(endpoint_name, version, args.delete(:pair)), args)
        Hashie::Mash.new({ result: result}).result
      end

      def v2_endpoints
        {
          :balance => [:balance],
          :user_transactions => [:user_transactions],
          :open_orders => [:open_orders, params: [:pair]],  # pair = all, return orders of all pairs
          :cancel_order => [:cancel_order, params: [:id]],
          :buy => [:buy_limit_order, params: [:pair, :amount, :price, :limit_price]],
          'buy/market' => [:buy_market_order, params: [:pair, :amount]],
          :sell => [:sell_limit_order, params: [:pair, :amount, :price, :limit_price]],
          'sell/market' => [:sell_market_order, params: [:pair, :amount]],
          :xrp_withdrawal => [:ripple_withdrawal, params: [:amount, :address]],
          :xrp_address => [:ripple_address]
        }
      end

      def endpoints
        {
          :withdrawal_requests => [:withdrawal_requests],
          :bitcoin_withdrawal => [:bitcoin_withdrawal, params: [:amount, :address]],
          :bitcoin_deposit_address => [:bitcoin_deposit_address],
          :unconfirmed_btc => [:unconfirmed_bitcoint_deposits]
        }
      end
    end
  end
end
