module LinkedinV2
  module Helpers
    module Handler
      def request(method, endpoint, params = {}, additional_headers = {}, api = API_URL)
        attrs = [ params, additional_headers ].reject(&:empty?)

        JSON.parse(conn(api)[endpoint].public_send(method, *attrs))
      rescue RestClient::ExceptionWithResponse => exception
        raise LinkedinResponseError.new("response error", details: exception.response)
      end

      def conn(api)
        RestClient::Resource.new(api, headers: headers)
      end

      def headers
        { "Authorization": "Bearer #{token}", "Content-Type": "application/json", }
      end

      def post_headers
        { "X-Restli-Protocol-Version": "2.0.0" }
      end
    end
  end
end
