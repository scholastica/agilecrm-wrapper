require 'agilecrm-wrapper/error'
require 'hashie'

module AgileCRMWrapper
  class Track < Hashie::Mash
    class << self
      def all
        response = AgileCRMWrapper.connection.get('milestone/pipelines')
        if response.status == 200
          return response.body.map { |body| new body }
        else
          return response
        end
      end
    end
  end
end
