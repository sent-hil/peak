require_relative '../../spec_helper'

describe Peak::Algorithms do
  subject { Peak.algorithms[:drop] }

  it 'returns algorithms name as part of result' do
    resp = subject.call [1,1,1,1,1]
    resp.name.should == :drop
  end

  it 'returns std dev as part of result' do
    resp = subject.call [1,1,1,1,1]
    resp.args[:deviation].should == 0
  end

  it 'returns true if last entry is less than x*std dev' do
    resp = subject.call [100,100,100,100,1]
    resp.result.should == true
  end

  it 'returns false if last entry is less than x*std dev' do
    resp = subject.call [1,1,2,2,1.5]
    resp.result.should == false
  end

  it 'returns false if theres no std dev' do
    resp = subject.call [1,1,1,1,1]
    resp.result.should == false
  end
end
