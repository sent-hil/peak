require_relative './response'
require_relative './algorithms'

module Peak
  module Algorithms
    Peak.algorithm :rise do |data|
      Algorithms.rise_drop_common :rise, data do |last, deviation|
        last > 3*deviation ? true : false
      end
    end
  end
end
