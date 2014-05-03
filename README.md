Peak
----

Peak is an anamoly detection service for your metrics. The project began when we wanted to automate anamoly detection, but existing solutions like Skyline and Nagios weren't suitable.

At the it's heart, Peak consists of four things:

* Metric    - item you want to monitor and detect anamoly
* Fetcher   - source you want to pull the metrics from
* Algorithm - determine if metric is an anamoly
* Alerter   - alert when metric is an anamoly

Here's a simple example:

```ruby
Peak.metric(:signups) do
  describe << end
  end

  fetcher(:elasticsearch,
    {:query => "signup", :index => "logstash"}
  )

  algorithm :less_than_10_percent

  alerter :slack
end
```

In above example we register an metric called :signups. This metric is fetched from Elasticsearch using query options passed to it, uses `:less_than_10_percent` algorithm and when that matches, it calls `:slack` alerter.

List of fetchers:
* :elasticsearch

List of algorithms:
* :simple_peak
* :simple_drop
* :peak_without_historic_peaks
* :drop_without_historic_drops
* :no_new_entries

List of alerters:
* slack
