require_relative '../../spec_helper'

describe Peak do
  context 'elasticsearch' do
    it 'returns algorithms name as part of result' do
      resp = Peak.algorithms[:rise].call [1,1,1,1,1]
      resp.name.should == :rise
    end

    it 'returns std dev as part of result' do
      resp = Peak.algorithms[:rise].call [1,1,1,1,1]
      resp.args[:deviation].should == 0
    end

    it 'returns true if last entry is more than x*std dev' do
      resp = Peak.algorithms[:rise].call [1,1,1,1,100]
      resp.result.should == true
    end

    it 'returns false if last entry is less than x*std dev' do
      resp = Peak.algorithms[:rise].call [1,1,2,2,1.5]
      resp.result.should == false
    end

    it 'returns false if theres no std dev' do
      resp = Peak.algorithms[:rise].call [1,1,1,1,1]
      resp.result.should == false
    end
  end
end
