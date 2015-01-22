require 'spec_helper'

describe AgileCRMWrapper::Track do
  describe '.all' do
    subject { AgileCRMWrapper::Track.all }

    it 'should return an array of Tracks' do
      expect(subject.map(&:class).uniq).to eq([AgileCRMWrapper::Track])
    end
  end
end
