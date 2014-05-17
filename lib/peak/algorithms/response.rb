module Peak
  module Algorithms
    class Response
      attr_reader :name, :result, :args

      def initialize(name, result, args=nil)
        @name   = name
        @result = result
        @args   = args
      end
    end
  end
end
