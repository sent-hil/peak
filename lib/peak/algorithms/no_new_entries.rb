require_relative './response'

module Peak
  module Algorithms
    interval = 60*10*1000 # 10 minutes

    Peak.algorithm :no_new_entries do |histogram|
      dates = histogram.keys.sort
      last = dates.pop

      result = (Time.now.to_i*1000)-last > interval ? true : false
      Response.new :no_new_entries, result, {:last_timestamp => last}
    end
  end
end
