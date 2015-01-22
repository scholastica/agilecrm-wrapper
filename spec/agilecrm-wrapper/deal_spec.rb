require 'spec_helper'

describe AgileCRMWrapper::Deal do
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
end
