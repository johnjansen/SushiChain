# Copyright © 2017-2018 The SushiChain Core developers
#
# See the LICENSE file at the top-level directory of this distribution
# for licensing information.
#
# Unless otherwise agreed in a custom licensing agreement with the SushiChain Core developers,
# no part of this software, including this file, may be copied, modified,
# propagated, or distributed except according to the terms contained in the
# LICENSE file.
#
# Removal or modification of this copyright notice is prohibited.

module ::Sushi::Core::DApps::BuildIn
  class Fees < DApp
    def setup
    end

    def transaction_actions : Array(String)
      [] of String
    end

    def transaction_related?(action : String) : Bool
      false
    end

    def valid_transaction?(transaction : Transaction, prev_transactions : Array(Transaction)) : Bool
      true
    end

    def record(chain : Blockchain::Chain)
    end

    def clear
    end

    def define_rpc?(call, json, context, params)
      case call
      when "fees"
        return fees(json, context, params)
      end

      nil
    end

    def fees(json, context, params)
      context.response.print api_success(fees_impl)
      context
    end

    def fees_impl
      fees = Hash(String, String).new

      blockchain.dapps.each do |dapp|
        dapp.transaction_actions.each do |action|
          fees[action] = scale_decimal(dapp.class.fee(action)) if dapp.class.fee(action) > 0
        end
      end

      fees
    end
  end
end
