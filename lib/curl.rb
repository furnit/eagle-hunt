require 'net/http'

module Curl
  class << self
    def get uri, data: nil
      uri = uri.strip
      raise Exception.new("you cannot curl an empty uri!") if not uri.length
      Net::HTTP.get_response init_uri(uri, data)

    rescue
      return false
    end

    protected

      def init_uri uri, params
        uri = URI.parse uri
        uri.query = URI.encode_www_form(params)
        uri
      end
  end
end