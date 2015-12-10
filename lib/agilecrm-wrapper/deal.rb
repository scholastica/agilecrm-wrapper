require 'agilecrm-wrapper/error'
require 'hashie'

module AgileCRMWrapper
  class Deal < Hashie::Mash
    DEFAULT_FIELDS = %w(id name description expected_value pipeline_id milestone
      probability close_date owner_id prefs contacts contact_ids)

    class << self

      def all
        results = []
        @cursor = nil

        until @no_more_results do
          response = call_agile_api(@cursor)
          results.concat(response)
          @cursor = response.last["cursor"]
          @no_more_results = @cursor.nil?
        end

        return results

      end

      def call_agile_api(cursor = nil)
        response = AgileCRMWrapper.connection.get("opportunity?cursor=#{cursor}")

        if response.status == 200
          return response.body.map { |body| new body }
        else
          return response
        end
      end

      def find(id)
        response = AgileCRMWrapper.connection.get("opportunity/#{id}")
        if response.status == 200
          new(response.body)
        elsif response.status == 204
          fail(AgileCRMWrapper::NotFound.new(response))
        end
      end


      def create_contact_deal(contact_email, options = {})
        payload = parse_deal_fields(options)
        response = AgileCRMWrapper.connection.post("opportunity/email/#{contact_email}", payload)
        new(response.body)
      end

      def update(options = {})
        payload = parse_deal_fields(options)
        response = AgileCRMWrapper.connection.put('opportunity', payload)
        new(response.body)
      end

      private

      def parse_deal_fields(options)
        payload = { 'custom_data' => [] }
        options.each do |key, value|
          if default_field?(key)
            payload[key.to_s] = value
          else
            payload['custom_data'] << { 'name' => key.to_s, 'value' => value }
          end
        end

        payload
      end

      def default_field?(key)
        DEFAULT_FIELDS.include?(key.to_s)
      end
    end
  end
end
