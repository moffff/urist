module Urist
  class Base
    attr_accessor :runner

    def initialize options={}
      @runner = Runner.new options
    end

    # starts script execution
    def go!
      @runner.go!
    end

    # returns all performed scenarios
    def scenarios
      @runner.done_scenarios
    end

    #  returns all results from all performed scenarios
    def logs
      @runner.log
    end
  end
end
