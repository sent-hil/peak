require_relative './response'

module Peak
  module Algorithms
    Peak.algorithm(:rise) do |data|
      last = data.pop
      deviation = data.std_dev

      result = if deviation == 0
        last == data[-1] ? false : true
      else
        last > 3*deviation ? true : false
      end

      Response.new(:rise, result, {:deviation => deviation})
    end
  end
end
