module LinkedinV2
  module Api
    module Profiles
      PROFILE_ENTITY = "person".freeze

      # Retrieve information about profile
      # https://docs.microsoft.com/en-us/linkedin/shared/integrations/people/profile-api
      def me(projection: nil)
        params = { projection: projection }
        path = LinkedinV2::Url::Builder.(:me, params)

        request(:get, path)
      end

      def add_profile_share(**options)
        attrs = options.merge(entity: PROFILE_ENTITY)
        body = LinkedinV2::Templates::Payloads::Shares.new(attrs)
        path = LinkedinV2::Url::Builder.(:shares)

        request(:post, path, body.to_json, post_headers)
      end

      def add_profile_post(**options)
        attrs = options.merge(entity: PROFILE_ENTITY)
        body = LinkedinV2::Templates::Payloads::UgcPost.new(attrs)
        path = LinkedinV2::Url::Builder.(:ugc_post)

        request(:post, path, body.to_json, post_headers)
      end
    end
  end
end
