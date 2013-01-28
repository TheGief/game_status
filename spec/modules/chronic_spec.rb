require 'spec_helper'

describe Chronic::Parser do
  let(:present) { Time.local(2013,1,1,10,0,0) }

  it 'should allow durations without spaces' do
    result = Chronic.parse('4hrs from 6pm', now: present)
    result.should == '2013-01-01 22:00:00 -0800'
  end

  describe 'pre_normalize method' do
    { '1hr' => '1 hr',
      '2hrs' => '2 hrs',
      '45min' => '45 min',
      '45minutes' => '45 minutes'
    }.each do |input, output|

      it "should translate #{input} to #{output}" do
        result = Chronic::Parser.new.pre_normalize(input)
        result.should == output
      end
    end
  end
end
