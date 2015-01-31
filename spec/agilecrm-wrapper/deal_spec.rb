require 'spec_helper'

describe AgileCRMWrapper::Deal do
  let(:deal) { AgileCRMWrapper::Deal.find(981) }
  describe '.create_contact_deal' do
    subject do
      AgileCRMWrapper::Deal.create_contact_deal(
        'contact@mail.com',
        { milestone: 'Pending', name: 'Deal name' }
      )
    end

    it 'creates a new deal' do
      expect(subject).to be_kind_of(AgileCRMWrapper::Deal)
    end
  end

  describe '.all' do
    subject { AgileCRMWrapper::Deal.all }

    it 'should return an array of Deals' do
      expect(subject.map(&:class).uniq).to eq([AgileCRMWrapper::Deal])
    end
  end

  describe '.find' do
    let(:id) { 981 }
    subject { AgileCRMWrapper::Deal.find(id) }

    context 'given an existing contact ID' do
      it { should be_kind_of(AgileCRMWrapper::Deal) }

      its(:id) { should eq id }
    end

    context 'given an unknown deal ID' do
      let(:id) { 0 }
      it { expect { is_expected.to raise_error(AgileCRMWrapper::NotFound) } }
    end
  end

  describe '#update' do
    it 'updates the receiving deal with the supplied key-value pair(s)' do
      result = deal.update(example_field: 'field', name: "example")
      expect(result[:name]).to eq 'example'
      expect(result[:example_field]).to eq 'field'
    end
  end
end
