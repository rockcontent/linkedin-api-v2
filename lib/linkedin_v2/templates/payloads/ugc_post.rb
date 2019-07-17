module LinkedinV2
  module Templates
    module Payloads
      class UgcPost < Base
        def initialize(**options)
          super(options)
        end

        def to_json
          payload.to_json
        end

        private

        def payload
          response = body
          response = deep_merge(response, picture_attribute) if has_attr?(picture)

          response
        end

        def body
          {
            "author" => "urn:li:#{entity}:#{identifier}",
            "lifecycleState" => "PUBLISHED",
            "specificContent" => {
              "com.linkedin.ugc.ShareContent" => {
                "shareCommentary" => {
                  "text" => text
                },
                "shareMediaCategory" => "NONE",
              }
            },
            "visibility" => {
              "com.linkedin.ugc.MemberNetworkVisibility" => "PUBLIC"
            }
          }
        end

        def entity
          options.fetch(:entity)
        end

        def identifier
          options.fetch(:identifier)
        end

        def text
          options.fetch(:text)
        end

        def picture
          options.fetch(:picture, nil)
        end

        def picture_attribute
          {
            "specificContent" => {
              "com.linkedin.ugc.ShareContent" => {
                "shareMediaCategory" => "IMAGE",
                "media" => [
                  {
                    "media": picture,
                    "status": "READY",
                  }
                ],
              }
            },
          }
        end
      end
    end
  end
end
