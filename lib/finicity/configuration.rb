module Finicity
  class Configuration
    attr_accessor :base_url,
      :logger,
      :partner_id,
      :partner_secret,
      :app_key,
      :proxy_url

    def initialize
      @logger = ::Logger.new(STDOUT)
    end
  end
end
