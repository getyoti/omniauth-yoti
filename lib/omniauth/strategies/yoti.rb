require 'omniauth'
require 'yoti'

module OmniAuth
  module Strategies
    class Yoti
      include OmniAuth::Strategy

      option :client_options

      def request_phase
        redirect "https://www.yoti.com/connect/#{options.client_options[:application_id]}"
      end

      uid { yoti_user_id }

      info do
        {
          name: yoti_user_profile['full_name'],
          selfie: yoti_user_profile['selfie'],
          full_name: yoti_user_profile['full_name'],
          given_names: yoti_user_profile['given_names'],
          family_name: yoti_user_profile['family_name'],
          phone_number: yoti_user_profile['phone_number'],
          email_address: yoti_user_profile['email_address'],
          date_of_birth: yoti_user_profile['date_of_birth'],
          postal_address: yoti_user_profile['postal_address'],
          gender: yoti_user_profile['gender'],
          nationality: yoti_user_profile['nationality'],
          base64_selfie_uri: base64_selfie_uri,
          age_verified: age_verified
        }
      end

      extra do
        {
          raw_info: raw_info
        }
      end

      def raw_info
        @raw_info ||= yoti_user_profile
      end

      private

      def yoti_activity_details
        @yoti_activity_details ||= begin
          configure_yoti_client!
          ::Yoti::Client.get_activity_details(token)
        end
      end

      def yoti_user_profile
        yoti_activity_details.user_profile
      end

      def yoti_user_id
        yoti_activity_details.user_id
      end

      def base64_selfie_uri
        yoti_activity_details.base64_selfie_uri
      end

      def age_verified
        yoti_activity_details.age_verified
      end

      def configure_yoti_client!
        ::Yoti.configure do |config|
          config.client_sdk_id = options.client_options[:client_sdk_id]
          config.key_file_path = options.client_options[:key_file_path]
          config.key = options.client_options[:key]
          config.sdk_identifier = 'OmniAuth'
        end
      end

      def token
        Rack::Utils.parse_nested_query(request.query_string)['token']
      end
    end
  end
end
