require_relative "api/organizations"
require_relative "api/profiles"
require_relative "api/medias"

module LinkedinV2
  class Client
    include LinkedinV2::Helpers::Handler
    include LinkedinV2::Api::Organizations
    include LinkedinV2::Api::Profiles
    include LinkedinV2::Api::Medias

    attr_reader :token

    def initialize(token:)
      @token = token
    end
  end
end
