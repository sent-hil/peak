require 'time'

module Peak
  class << self
    attr_reader :metrics, :fetchers, :algorithms, :alerters

    def metric(name, &blk)
      metric = Metric.new(name)
      metric.instance_eval(&blk)  if block_given?

      @metrics ||= []
      @metrics << metric
    end

    def fetcher(name, &blk)
      @fetchers ||= {}
      @fetchers[name] = blk
    end

    def algorithm(name, &blk)
      @algorithms ||= {}
      @algorithms[name] = blk
    end

    def alerter(name, &blk)
      @alerters ||= {}
      @alerters[name] = blk
    end
  end
end

require_relative './peak/metric'
require_relative './peak/fetchers/elasticsearch'
