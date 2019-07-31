module LinkedinV2
  module Templates
    module Payloads
      class Shares < Base
        def initialize(**options)
          super(options)
        end

        def to_json
          payload.to_json
        end

        private

        def payload
          response = body
          if Helpers::Attribute.present?(description)
            response = Helpers::Hash.deep_merge(response, description_attribute)
          end
          if Helpers::Attribute.present?(title)
            response = Helpers::Hash.deep_merge(response, title_attribute)
          end

          response
        end

        def body
          {
            "owner" => "urn:li:#{entity}:#{identifier}",
            "content" => {
              "contentEntities" => [
                {
                  "entityLocation" => url,
                  "thumbnails" => [
                    {
                      "resolvedUrl": thumbnail,
                    }
                  ],
                }
              ]
            },
            "distribution" => {
              "linkedInDistributionTarget" => {}
            },
            "text" => {
              "text" => text
            }
          }
        end

        attr_reader :options

        def entity
          options.fetch(:entity)
        end

        def identifier
          options.fetch(:identifier)
        end

        def url
          options.fetch(:url)
        end

        def text
          options.fetch(:text)
        end

        def thumbnail
          options.fetch(:thumbnail, nil)
        end

        def title
          options.fetch(:title, nil)
        end

        def description
          options.fetch(:description, nil)
        end

        def description_attribute
          {
            "content" => {
              "description" => description,
            },
          }
        end

        def title_attribute
          {
            "content" => {
              "title" => title,
            },
          }
        end
      end
    end
  end
end
