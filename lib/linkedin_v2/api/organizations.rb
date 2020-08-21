module LinkedinV2
  module Api
    module Organizations
      ORGANIZATION_ENTITY = "organization".freeze

      # Retrieve information about organizations
      # https://docs.microsoft.com/en-us/linkedin/marketing/integrations/community-management/organizations/organization-access-control
      def organizations(projection: nil, start: nil, count: nil)
        params = { projection: projection, start: start, count: count }
        path = LinkedinV2::Url::Builder.(:organizations, params)

        request(:get, path)
      end

      # Retrieve Organization Logos and Cover Photos
      # https://docs.microsoft.com/en-us/linkedin/marketing/integrations/community-management/organizations/organization-lookup-api#retrieve-organization-logos--cover-photos
      def company_brand(identifier:, projection: nil)
        params = { identifier: identifier, projection: projection }
        path = LinkedinV2::Url::Builder.(:company, params)

        request(:get, path)
      end

      def upload_company_asset(**options)
        attrs = options.merge(entity: ORGANIZATION_ENTITY)

        upload_asset(attrs)
      end

      def add_company_share(**options)
        attrs = options.merge(entity: ORGANIZATION_ENTITY)
        body = LinkedinV2::Templates::Payloads::Shares.new(attrs)
        path = LinkedinV2::Url::Builder.(:shares)

        request(:post, path, body.to_json, post_headers)
      end

      def add_company_post(**options)
        attrs = options.merge(entity: ORGANIZATION_ENTITY)
        body = LinkedinV2::Templates::Payloads::UgcPost.new(attrs)
        path = LinkedinV2::Url::Builder.(:ugc_post)

        request(:post, path, body.to_json, post_headers)
      end
    end
  end
end
