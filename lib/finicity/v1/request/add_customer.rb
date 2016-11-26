module Finicity::V1
  module Request
    class AddCustomer
      include ::Finicity::Logger
      extend ::HTTPClient::IncludeClient
      include_http_client do |client|
        client.cookie_manager = nil
        client.proxy = ::Finicity.config.proxy_url
      end

      ##
      # Attributes
      #
      attr_accessor :token,
        :user_guid,:first_name, :last_name, :email

      ##
      # Instance Methods
      #
      def initialize(token, user_guid, options)
        @token = token
        @user_guid = user_guid
        @first_name = options[:first_name]
        @last_name = options[:last_name]
        @email = options[:email]
      end

      def add_customer
        http_client.post(url, body, headers)
      end
      
      def add_testing_customer
        http_client.post(test_url, body, headers)
      end

      def body
        {
          'username' => user_guid,
          'email' => email,
          'firstName' =>first_name,
          'lastName' => last_name
        }.to_xml(:root => 'customer')
      end

      def headers
        {
          'Finicity-App-Key' => ::Finicity.config.app_key,
          'Finicity-App-Token' => token,
          'Content-Type' => 'application/xml'
        }
      end

      def url
        ::URI.join(
          ::Finicity.config.base_url,
          'v1/',
          'customers/',
          'active'
        )
      end
      
      def test_url
        ::URI.join(
          ::Finicity.config.base_url,
          'v1/',
          'customers/',
          'testing'
        )
      end
    end
  end
end
