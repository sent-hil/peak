require_relative './response'

module Peak
  module Algorithms
    Peak.algorithm(:rise) do |data|
      deviation = data[0...data.length-1].std_dev
      result = if deviation == 0
        data[-1] == data[-2] ? false : true
      else
        data[-1] > 3*deviation ? true : false
      end

      Response.new(:rise, result, {:deviation => deviation})
    end
  end
end
