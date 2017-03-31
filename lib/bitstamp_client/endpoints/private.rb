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
          :buy_limit_order => [:buy, params: [:pair, :amount, :price, :limit_price]],
          :buy_market_order => ['buy/market', params: [:pair, :amount]],
          :sell_limit_order => [:sell, params: [:pair, :amount, :price, :limit_price]],
          :sell_market_order => ['sell/market', params: [:pair, :amount]],
          :ripple_withdrawal => [:xrp_withdrawal, params: [:amount, :address]],
          :ripple_address => [:xrp_address]
        }
      end

      def endpoints
        {
          :withdrawal_requests => [:withdrawal_requests],
          :bitcoin_withdrawal => [:bitcoin_withdrawal, params: [:amount, :address]],
          :bitcoin_deposit_address => [:bitcoin_deposit_address],
          :unconfirmed_bitcoint_deposits => [:unconfirmed_btc]
        }
      end
    end
  end
end
