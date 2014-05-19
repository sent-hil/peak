require_relative 'spec_helper'

describe Peak do
  context 'fetcher' do
    it 'registers fetcher with name' do
      expect {Peak.fetcher(:test_elasticsearch) {}}.
        to change{Peak.fetchers.count}.by 1
    end

    it 'defines get_fetcher method' do
      Peak.get_fetcher(:test_elasticsearch).should_not == nil
    end
  end

  context 'algorithm' do
    it 'registers algorithm with name' do
      expect {Peak.algorithm(:peak) {}}.
        to change {Peak.algorithms.count}.by 1
    end

    it 'defines get_algorithm method' do
      Peak.get_algorithm(:peak).should_not == nil
    end
  end

  context 'alerter' do
    it 'registers alerter with name' do
      Peak.alerter(:slack) {}
      Peak.alerters.count.should == 1
    end

    it 'defines get_slack method' do
      Peak.get_alerter(:slack).should_not == nil
    end
  end

  context 'metric' do
    it 'registers a metric to be tracked' do
      Peak.metric :indiana_jones
      Peak.metrics.count.should == 1
    end

    it 'registers metric with description' do
      Peak.metric :indiana_jones do
        describe 'famous archaeologist'
      end

      met = Peak.metrics.last
      met.description.should == 'famous archaeologist'
    end

    it 'registers metric with fetcher' do
      expect do
        Peak.fetcher(:elasticsearch) {}

        Peak.metric :indiana_jones do
          fetcher :elasticsearch, :query => 'grail'
        end
      end.not_to raise_exception
    end
  end
end
