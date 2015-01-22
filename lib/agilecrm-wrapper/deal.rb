require 'agilecrm-wrapper/error'
require 'hashie'

module AgileCRMWrapper
  class Deal < Hashie::Mash
    class << self
      def create_contact_deal(contact_email, options = {})
        response = AgileCRMWrapper.connection.post("opportunity/email/#{contact_email}", options)
        new(response.body)
      end
    end
  end
end
