require_relative 'spec_helper'

module Peak
  class << self
    def store
      @store ||= {}
    end

    def clear
      instance_variables.each do |var|
        store[var] ||= {}
        store[var] = instance_variable_get(var)

        instance_variable_set(var, nil)
      end
    end

    def replace
      store.each do |key, value|
        instance_variable_set(key, value)
      end
    end
  end
end

describe Peak do
  before(:all) { Peak.clear }
  after(:all) { Peak.replace }

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
