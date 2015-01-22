require 'agilecrm-wrapper/error'
require 'hashie'

module AgileCRMWrapper
  class Deal < Hashie::Mash
    DEFAULT_FIELDS = %w(name description expected_value pipeline_id milestone
      probability close_date owner_id prefs contacts contact_ids)

    class << self
      def create_contact_deal(contact_email, options = {})
        payload = parse_deal_fields(options)
        response = AgileCRMWrapper.connection.post("opportunity/email/#{contact_email}", payload)
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
