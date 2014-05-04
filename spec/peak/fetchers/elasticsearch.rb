require_relative '../../spec_helper'

describe Peak do
  context 'elasticsearch' do
    it 'fetches data from elasticsearch' do
      blk = Peak.fetchers[:elasticsearch]
      resp = blk.call(
        :index => 'errorlogs-2014.05.01',
      )

      resp.should_not == nil
    end
  end
end
