module Peak
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
