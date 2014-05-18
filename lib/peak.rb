require 'time'
require 'pry'

module Peak
  class << self
    attr_reader :metrics, :fetchers, :algorithms, :alerters

    def metric(name, &blk)
      metric = Metric.new name
      metric.instance_eval(&blk)  if block_given?

      @metrics ||= []
      @metrics << metric
    end

    # Defines method that takes name and blk as arguments,
    # stores them in a hash with same name as method.
    #
    # Example:
    #   def fetcher(name, &blk)
    #     @fetchers ||= {}
    #     @fetchers[name] = blk
    #   end
    [:fetcher, :algorithm, :alerter].each do |method|
      define_method method do |name, &blk|
        ivar = instance_variable_get("@#{method}s") || {}
        ivar[name] = blk

        instance_variable_set "@#{method}s", ivar
      end
    end
  end
end

require_relative './peak/core_ext/enumerable'
require_relative './peak/metric'
require_relative './peak/fetchers/elasticsearch'
require_relative './peak/algorithms/rise'
require_relative './peak/algorithms/drop'
require_relative './peak/algorithms/no_new_entries'
