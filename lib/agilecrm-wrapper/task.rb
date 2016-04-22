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

    end
  end
end
