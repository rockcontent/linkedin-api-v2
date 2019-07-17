module LinkedinV2
  module Api
    module Medias
      def upload_image(picture_url:)
        file = Files::Creator.(picture_url)
        body = { file: file }
        path = LinkedinV2::Url::Builder.(:upload_image)

        request(:post, path, body, {}, API_V1_URL)
      ensure
        Files::Destroyer.(file)
      end
    end
  end
end
