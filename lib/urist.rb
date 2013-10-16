require 'urist/base'
require 'urist/uber_waffel'
require 'urist/runner'
require 'urist/scenario'

# == How to use: ==
#
# A. Fetch all the data you need:
#   client   = Client.needed_now # instance of some class
#   price    = 10000.65          # numbers
#   products = client.products   # arrays
#
# B. Assemble them into hash:
#   information = {:client => client, :price => price, :products => products}
#
# C. Create new runner and, well, run it:
#   runner = Urist.new(:startup_scenario => NewAndLongScenario, :information => information)
#   result = runner.go!
#
# D. Extract the decision and other parameters from result:
#   decision    = result[:decision]
#   description = result[:description]
#   limit       = result[:limit]
#
# E. Capture all execution logs
#   log = runner.logs # array with all results
#
# F. Summarize all executed scenarios
#   scenarios = runner.scenarios # array with all executed scenarios
#
# G. You're done!

module Urist
  def self.new options={}
    Base.new options
  end
end
