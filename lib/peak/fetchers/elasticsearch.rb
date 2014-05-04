require 'tire'
require 'time'

module Peak
  module Fetchers
    Peak.fetcher(:elasticsearch) do |args|
      index    = args[:index]
      query    = args[:query]    || '*'
      interval = args[:interval] || 12
      field    = args[:field]    || '@timestamp'
      from     = args[:from]
      till     = args[:till]

      s = Tire.search index do
        query do
          string query
        end

        facet 'date_histogram' do
          histogram field, :interval => interval

          time_query = {}
          time_query[:from] = from  if from
          time_query[:till] = till  if till

          unless time_query.empty?
            facet_filter :range, {field => time_query}
          end
        end
      end

      {}.tap do |result|
        s.results.facets['date_histogram']['entries'].each do |k|
          key = Time.at(k['key']/1000).utc.iso8601

          result[key] = k['count']
        end
      end
    end
  end
end
