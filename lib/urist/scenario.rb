module Urist
  class Scenario
    attr_accessor :information

    # more candies and sugar for scenarios
    include UberWaffel
    inheritable_attributes :links
    @links = {}

    def initialize options={}
      @information = options[:information]

      validate!
    end

    private
      def validate!
        raise ArgumentError, ":information should be assigned to #{self.class}. #{@information.inspect} given." if @information.nil?
        raise ArgumentError, "@links should be a Hash in #{self.class}. #{self.class.links.inspect} given." unless self.class.links.is_a? Hash
      end
  end
end
