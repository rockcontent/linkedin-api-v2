module LinkedinV2
  module Api
    module Assets
      def register_asset_upload(**options)
        body = LinkedinV2::Templates::Payloads::RegisterAssetUpload.new(options)
        path = LinkedinV2::Url::Builder.(:register_asset_upload)

        request(:post, path, body.to_json, post_headers)
      end

      def upload_asset(**options)
        register_asset_upload_response = register_asset_upload(options)
        upload_url = LinkedinV2::Helpers::Hash.get_deep(
          register_asset_upload_response,
          "value",
          "uploadMechanism",
          "com.linkedin.digitalmedia.uploading.MediaUploadHttpRequest",
          "uploadUrl"
        )
        asset_urn = LinkedinV2::Helpers::Hash.get_deep(register_asset_upload_response, "value", "asset")
        file = Files::Creator.(options[:asset_url])

        response = request(:post, nil, file, post_headers, upload_url, "application/octet-stream")

        response.code == 201 ? asset_urn : nil
      ensure
        Files::Destroyer.(file)
      end
    end
  end
end
