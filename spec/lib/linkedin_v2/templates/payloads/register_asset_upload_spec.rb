require "spec_helper"

describe LinkedinV2::Templates::Payloads::RegisterAssetUpload do
  subject(:payload) { described_class }
  let(:default_attrs) do
    { entity: "entity", identifier: "identifier" }
  end

  describe "#to_json" do
    context "when entity parameter is given" do
      it "responds successfully with a JSON object" do
        expected_response = "{\"registerUploadRequest\":{\"owner\":\"urn:li:entity:identifier\",\"recipes\":[\"urn:li:digitalmediaRecipe:feedshare-image\"],\"serviceRelationships\":[{\"identifier\":\"urn:li:userGeneratedContent\",\"relationshipType\":\"OWNER\"}]}}"
        body = payload.new(default_attrs)

        result = body.to_json

        expect(result).to eq(expected_response)
      end
    end

    context "when entity parameter is not given" do
      it "raises KeyError exception" do
        default_attrs.delete(:entity)
        body = payload.new(default_attrs)

        expect {
          body.to_json
        }.to raise_error(KeyError)
      end
    end

    context "when identifier parameter is given" do
      it "responds successfully with a JSON object" do
        expected_response = "{\"registerUploadRequest\":{\"owner\":\"urn:li:entity:identifier\",\"recipes\":[\"urn:li:digitalmediaRecipe:feedshare-image\"],\"serviceRelationships\":[{\"identifier\":\"urn:li:userGeneratedContent\",\"relationshipType\":\"OWNER\"}]}}"
        body = payload.new(default_attrs)

        result = body.to_json

        expect(result).to eq(expected_response)
      end
    end

    context "when identifier parameter is not given" do
      it "raises KeyError exception" do
        default_attrs.delete(:identifier)
        body = payload.new(default_attrs)

        expect {
          body.to_json
        }.to raise_error(KeyError)
      end
    end
  end
end
