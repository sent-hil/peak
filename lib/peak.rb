module Peak
  class << self
    attr_reader :metrics, :fetchers, :algorithms, :alerters

    def clear
      instance_variables.each do |var|
        instance_variable_set(var, nil)
      end
    end

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
