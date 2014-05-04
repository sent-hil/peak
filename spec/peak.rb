require_relative 'spec_helper'

describe Peak do
  before do
    Peak.clear
  end

  context 'fetcher' do
    it 'registers a fetcher with name and args' do
      Peak.fetcher(:elasticsearch) {}
      Peak.fetchers.count.should == 1
    end
  end

  context 'algorithm' do
    it 'registers algorithm with name' do
      Peak.algorithm(:peak) {}
      Peak.algorithms.count.should == 1
    end
  end

  context 'alerter' do
    it 'registers alerter with name' do
      Peak.alerter(:slack) {}
      Peak.alerters.count.should == 1
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

      met = Peak.metrics.first
      met.description.should == 'famous archaeologist'
    end

    it 'registers metric with fetcher' do
      expect do
        Peak.fetcher(:elasticsearch) {}

        Peak.metric :indiana_jones do
          register_fetcher :elasticsearch, :query => 'grail'
        end
      end.not_to raise_exception
    end
  end
end
