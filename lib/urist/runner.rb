module Urist
  class Runner
    attr_accessor :information, :result, :log
    attr_accessor :active_scenario, :done_scenarios

    def initialize options={}
      @information     = options[:information] || {}
      @active_scenario = options[:startup_scenario]
      @done_scenarios  = []
      @log             = []

      validate!
    end

    def go!
      run_active_scenario while @active_scenario

      return @result
    end

    private
      def run_active_scenario
        check_for_duplicate_scenario!
        execute_active_scenario!
        validate_result!
        log_result!
        assign_next_scenario!
      end

      def assign_next_scenario!
        decision = @result[:decision]
        @active_scenario = @active_scenario.links[decision]
      end

      def log_result!
        @log << @result
      end

      def validate_result!
        raise ArgumentError, "Incorrect 'result' in #{@active_scenario.inspect}. Result must be returned as Hash." unless @result.is_a? Hash
        raise ArgumentError, "Incorrect 'result' in #{@active_scenario.inspect}. Result must include ':decision' key." unless @result.has_key? :decision
      end

      def execute_active_scenario!
        @result = @active_scenario.new(:information => @information).logic
      end

      # raise an exception if detected that scripts start looping
      def check_for_duplicate_scenario!
        if @done_scenarios.include? @active_scenario
          raise RuntimeError, "Current scenario has already been passed. Current #{@active_scenario.inspect}. Previous #{@done_scenarios.last}"
        else
          @done_scenarios << @active_scenario
        end
      end

      def validate!
        raise ArgumentError, ":information should be assigned. #{@information.inspect} given." if @information.nil?
        raise ArgumentError, ":startup_scenario should be assigned. #{@active_scenario.inspect} given." if @active_scenario.nil?
      end
  end
end
