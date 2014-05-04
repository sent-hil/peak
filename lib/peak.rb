module Peak
  class << self
    def clear
      @metrics    = []
      @fetchers   = {}
      @algorithms = {}
      @alerters   = {}
    end

    def metrics
      @metrics ||= []
    end

    def metric(name, &blk)
      metric = Metric.new(name)
      metric.instance_eval(&blk)  if block_given?

      metrics << metric
    end

    def fetchers
      @fetchers ||= {}
    end

    def fetcher(name, &blk)
      fetchers[name] = blk
    end

    def algorithms
      @algorithms ||= {}
    end

    def algorithm(name, &blk)
      algorithms[name] = blk
    end

    def alerters
      @alerters ||= {}
    end

    def alerter(name, &blk)
      alerters[name] = blk
    end
  end

  class Fetcher
    def initialize(name, &blk)
      @name = name
      @blk  = blk
    end
  end

  class Metric
    attr_reader :description

    def initialize(name)
      @name = name
    end

    def describe(text)
      @description = text
    end

    def fetcher(name, args)
      @fetcher = Peak.fetchers[name]

      unless @fetcher
        raise "No fetcher found with name #{name}"
      end

      @fetcher_args = args
    end
  end
end
