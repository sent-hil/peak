require_relative './response'
require_relative './algorithms'

module Peak
  module Algorithms
    Peak.algorithm :drop do |data|
      Algorithms.rise_drop_common :drop, data do |last, deviation|
        last < 3*deviation ? true : false
      end
    end
  end
end
