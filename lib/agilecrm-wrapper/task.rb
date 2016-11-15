require 'agilecrm-wrapper/error'
require 'hashie'

module AgileCRMWrapper
  class Task < Hashie::Mash
    class << self

      def all
        response = AgileCRMWrapper.connection.get("tasks/based?pending=true&page_size=5000")
        if response.status == 200
          return response.body.map { |body| new body }
        else
          return response
        end
      end

      def find_by_contact(contact_id)
        response = AgileCRMWrapper.connection.get("contacts/#{contact_id}/tasks/sort")
        if response.status == 200
          response.body
        elsif response.status == 204
          fail(AgileCRMWrapper::NotFound.new(response))
        end
      end

    end
  end
end
