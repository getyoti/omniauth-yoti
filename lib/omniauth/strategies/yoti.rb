require 'omniauth'
require 'yoti'
require 'pry'

module OmniAuth
  module Strategies
    class Yoti
      include OmniAuth::Strategy

      option :config, [:application_id, :client_sdk_id, :key_file_path]

      def request_phase
        redirect "https://www.yoti.com/connect/#{options.config.first.application_id}"
      end

      uid { @yoti_activity_details.user_id }
      info { { name: @yoti_activity_details.user_id } }

      def extra
        @raw_info ||= begin
          user_profile = @yoti_activity_details.user_profile
          {
            photo: user_profile['selfie'],
            given_names: user_profile['given_names'],
            family_name: user_profile['family_name'],
            mobile_number: user_profile['phone_number'],
            date_of_birth: user_profile['date_of_birth'],
            address: user_profile['post_code'],
            gender: user_profile['gender'],
            nationality: user_profile['nationality']
          }
        end
      end

      def callback_phase
        ::Yoti.configure do |config|
          config.client_sdk_id = options.config.first.client_sdk_id
          config.key_file_path = options.config.first.key_file_path
        end

        token = Rack::Utils.parse_nested_query(request.query_string)['token']
        @yoti_activity_details = ::Yoti::Client.get_activity_details(token)

        super
      end
    end
  end
end
