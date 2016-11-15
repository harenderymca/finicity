module Finicity
  class GenericError < ::StandardError
    ERROR_CODE_MAP = {
      '102' => 'Oops. Service Unavailable, please try again after some time.',
      '320' => 'Oops. Service Unavailable, please try again after some time.',
      '580' => 'Oops. Service Unavailable, please try again after some time.',
      '103' => 'Oops. Invalid Credentials, please try again!.',
      '106' => 'Account Name/Number/Type mismatch.',
      '108' => 'End user action required at the third party site.',
      '109' => 'Password change required at the third party site.',
      '123' => 'Oops. Service Unavailable, please try again after some time.',
      '125' => 'Oops. Service Unavailable, please try again after some time.',
      '127' => 'Oops. Service Unavailable, please try again after some time.',
      '128' => 'Oops. Service Unavailable, please try again after some time.',
      '130' => 'Oops. Service Unavailable, please try again after some time.',
      '185' => 'MFA answer(s) missing.',
      '187' => 'Invalid MFA.',
      '331' => 'Oops. Transaction timed out! Please input your credentials again.',
    }
    attr_reader :error_message, :http_status, :finicity_code

    def initialize(error_message = nil, http_status = nil, finicity_code = nil)
      @error_message = error_message
      @http_status = http_status
      @finicity_code = finicity_code
    end

    def to_s
      custom_message = ERROR_CODE_MAP[finicity_code.to_s] || error_message
      "#{custom_message}"
    end
    
    def http_status
      code = 500
      unless ERROR_CODE_MAP[finicity_code.to_s].blank?
        code = 103 
      end
      return code
    end
  end

  class AuthenticationError < ::Finicity::GenericError
  end

  class DuplicateCustomerError < ::StandardError
    attr_reader :username

    def initialize(username)
      @username = username
    end

    def to_s
      "Multiple customers found with username: #{username}"
    end
  end

  class FinicityAggregationError < ::StandardError
    ERROR_CODE_MAP = {
      '0' => 'Success.',
      '102' => 'Oops. Service Unavailable, please try again after some time.',
      '320' => 'Oops. Service Unavailable, please try again after some time.',
      '580' => 'Oops. Service Unavailable, please try again after some time.',
      '103' => 'Oops. Invalid Credentials, please try again!.',
      '106' => 'Account Name/Number/Type mismatch.',
      '108' => 'End user action required at the third party site.',
      '109' => 'Password change required at the third party site.',
      '123' => 'Oops. Service Unavailable, please try again after some time.',
      '125' => 'Oops. Service Unavailable, please try again after some time.',
      '127' => 'Oops. Service Unavailable, please try again after some time.',
      '128' => 'Oops. Service Unavailable, please try again after some time.',
      '130' => 'Oops. Service Unavailable, please try again after some time.',
      '185' => 'MFA answer(s) missing.',
      '187' => 'Invalid MFA.',
      '331' => 'Oops. Transaction timed out! Please input your credentials again.',
    }

    attr_reader :aggregation_status_code

    def initialize(aggregation_status_code)
      @aggregation_status_code = aggregation_status_code
    end

    def error_message
      ERROR_CODE_MAP[aggregation_status_code.to_s] || 'Unknown Error'
    end

    def to_s
      "#{error_message}"
    end
    
  end

  class InvalidCredentialsError < ::Finicity::FinicityAggregationError
  end
end
