require_relative '../../spec_helper'

describe 'Peak::Algorithms#no_new_entries' do
  subject { Peak.algorithms[:no_new_entries] }

  it 'returns false last entry was later than interval' do
    eleven_minutes_ago = (Time.now.to_i-60*11)*1000
    resp = subject.call({eleven_minutes_ago => 1})

    resp.result.should == true
  end

  it 'returns false last entry was earlier than interval' do
    nine_minutes_ago = (Time.now.to_i-60*9)*1000
    resp = subject.call({nine_minutes_ago => 1})

    resp.result.should == false
  end

  it 'returns last timestamp' do
    time = Time.now.to_i*1000
    resp = subject.call({time => 1})

    resp.args[:last_timestamp].should == time
  end
end
