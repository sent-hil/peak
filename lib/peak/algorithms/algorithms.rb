module Peak
  module Algorithms
    class << self
      def rise_drop_common(name, data, &blk)
        last = data.pop
        deviation = data.std_dev

        result = if deviation == 0
          last == data[-1] ? false : true
        else
          blk.call last, deviation
        end

        Response.new(name, result, {:deviation => deviation})
      end
    end
  end
end
