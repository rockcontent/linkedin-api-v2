module LinkedinV2
  module Url
    class Builder
      def self.call(key, **options)
        new.(key, options)
      end

      # key -> Symbol object - Name of method to get endpoint Files::Reader.
      # options -> Hash object - Each method needs a specific parameter
      def call(key, **options)
        path = options.empty? ? send(key) : send(key, Helpers::Url.escape(**options))

        path.strip
      rescue NoMethodError, ArgumentError => exception
        raise InvalidEndpointError.new("endpoint not found", details: exception.message)
      end

      private

      def shares
        ERB.new(Files::Reader.(__method__)).result
      end

      def ugc_post
        ERB.new(Files::Reader.(__method__)).result
      end

      # 'projection' - query to get specific attributes - optional
      def organizations(projection: nil)
        ERB.new(Files::Reader.(__method__)).result_with_hash({ projection: projection })
      end

      # 'identifier' - organization id - required
      # 'projection' - query to get specific attributes - optional
      def company(identifier:, projection: nil)
        ERB.new(
          Files::Reader.(__method__)
        ).result_with_hash({ identifier: identifier, projection: projection })
      end

      # 'identifier' - organization id - required
      def logo(identifier:)
        ERB.new(Files::Reader.(__method__)).result_with_hash({ identifier: identifier })
      end

      def upload_image
        ERB.new(Files::Reader.(__method__)).result
      end

      # 'projection' - query to get specific attributes - optional
      def me(projection: nil)
        ERB.new(Files::Reader.(__method__)).result_with_hash({ projection: projection })
      end
    end
  end
end
