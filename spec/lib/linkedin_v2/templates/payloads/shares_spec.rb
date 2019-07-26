require "spec_helper"

describe LinkedinV2::Templates::Payloads::Shares do
  subject(:payload) { described_class }
  let(:default_attrs) do
    { entity: "entity", identifier: "identifier", url: "url", text: "text" }
  end

  describe "#to_json" do
    context "when entity parameter is given" do
      it "responds successfully with a JSON object" do
        expected_response = "{\"owner\":\"urn:li:entity:identifier\",\"content\":{\"contentEntities\":[{\"entityLocation\":\"url\",\"thumbnails\":[{\"resolvedUrl\":null}]}]},\"distribution\":{\"linkedInDistributionTarget\":{}},\"text\":{\"text\":\"text\"}}"
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

    context "when text parameter is given" do
      it "responds successfully with a JSON object" do
        expected_response = "{\"owner\":\"urn:li:entity:identifier\",\"content\":{\"contentEntities\":[{\"entityLocation\":\"url\",\"thumbnails\":[{\"resolvedUrl\":null}]}]},\"distribution\":{\"linkedInDistributionTarget\":{}},\"text\":{\"text\":\"text\"}}"
        body = payload.new(default_attrs)

        result = body.to_json

        expect(result).to eq(expected_response)
      end
    end

    context "when text parameter is not given" do
      it "raises KeyError exception" do
        default_attrs.delete(:text)
        body = payload.new(default_attrs)

        expect {
          body.to_json
        }.to raise_error(KeyError)
      end
    end

    context "when url parameter is given" do
      it "responds successfully with a JSON object" do
        expected_response = "{\"owner\":\"urn:li:entity:identifier\",\"content\":{\"contentEntities\":[{\"entityLocation\":\"url\",\"thumbnails\":[{\"resolvedUrl\":null}]}]},\"distribution\":{\"linkedInDistributionTarget\":{}},\"text\":{\"text\":\"text\"}}"
        body = payload.new(default_attrs)

        result = body.to_json

        expect(result).to eq(expected_response)
      end
    end

    context "when url parameter is not given" do
      it "raises KeyError exception" do
        default_attrs.delete(:url)
        body = payload.new(default_attrs)

        expect {
          body.to_json
        }.to raise_error(KeyError)
      end
    end

    context "when identifier parameter is given" do
      it "responds successfully with a JSON object" do
        expected_response = "{\"owner\":\"urn:li:entity:identifier\",\"content\":{\"contentEntities\":[{\"entityLocation\":\"url\",\"thumbnails\":[{\"resolvedUrl\":null}]}]},\"distribution\":{\"linkedInDistributionTarget\":{}},\"text\":{\"text\":\"text\"}}"
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

    context "when thumbnail parameter is given" do
      it "responds successfully with a JSON object" do
        default_attrs.merge!(thumbnail: "thumbnail")
        expected_response = "{\"owner\":\"urn:li:entity:identifier\",\"content\":{\"contentEntities\":[{\"entityLocation\":\"url\",\"thumbnails\":[{\"resolvedUrl\":\"thumbnail\"}]}]},\"distribution\":{\"linkedInDistributionTarget\":{}},\"text\":{\"text\":\"text\"}}"
        body = payload.new(default_attrs)

        result = body.to_json

        expect(result).to eq(expected_response)
      end
    end

    context "when thumbnail parameter is not given" do
      it "responds successfully with a JSON object" do
        expected_response = "{\"owner\":\"urn:li:entity:identifier\",\"content\":{\"contentEntities\":[{\"entityLocation\":\"url\",\"thumbnails\":[{\"resolvedUrl\":null}]}]},\"distribution\":{\"linkedInDistributionTarget\":{}},\"text\":{\"text\":\"text\"}}"
        body = payload.new(default_attrs)

        result = body.to_json

        expect(result).to eq(expected_response)
      end
    end

    context "when title parameter is given" do
      it "responds successfully with a JSON object" do
        default_attrs.merge!({ title: "title" })
        expected_response = "{\"owner\":\"urn:li:entity:identifier\",\"content\":{\"contentEntities\":[{\"entityLocation\":\"url\",\"thumbnails\":[{\"resolvedUrl\":null}]}],\"title\":\"title\"},\"distribution\":{\"linkedInDistributionTarget\":{}},\"text\":{\"text\":\"text\"}}"
        body = payload.new(default_attrs)

        result = body.to_json

        expect(result).to eq(expected_response)
      end
    end

    context "when title parameter is not given" do
      it "responds successfully with a JSON object" do
        expected_response = "{\"owner\":\"urn:li:entity:identifier\",\"content\":{\"contentEntities\":[{\"entityLocation\":\"url\",\"thumbnails\":[{\"resolvedUrl\":null}]}]},\"distribution\":{\"linkedInDistributionTarget\":{}},\"text\":{\"text\":\"text\"}}"
        body = payload.new(default_attrs)

        result = body.to_json

        expect(result).to eq(expected_response)
      end
    end

    context "when description parameter is given" do
      it "responds successfully with a JSON object" do
        default_attrs.merge!(description: "description")
        expected_response = "{\"owner\":\"urn:li:entity:identifier\",\"content\":{\"contentEntities\":[{\"entityLocation\":\"url\",\"thumbnails\":[{\"resolvedUrl\":null}]}],\"description\":\"description\"},\"distribution\":{\"linkedInDistributionTarget\":{}},\"text\":{\"text\":\"text\"}}"
        body = payload.new(default_attrs)

        result = body.to_json

        expect(result).to eq(expected_response)
      end
    end

    context "when description parameter is not given" do
      it "responds successfully with a JSON object" do
        expected_response = "{\"owner\":\"urn:li:entity:identifier\",\"content\":{\"contentEntities\":[{\"entityLocation\":\"url\",\"thumbnails\":[{\"resolvedUrl\":null}]}]},\"distribution\":{\"linkedInDistributionTarget\":{}},\"text\":{\"text\":\"text\"}}"
        body = payload.new(default_attrs)

        result = body.to_json

        expect(result).to eq(expected_response)
      end
    end

    context "when description and title are given" do
      it "responds successfully with a JSON object" do
        default_attrs.merge!(description: "description")
        default_attrs.merge!(title: "title")
        expected_response = "{\"owner\":\"urn:li:entity:identifier\",\"content\":{\"contentEntities\":[{\"entityLocation\":\"url\",\"thumbnails\":[{\"resolvedUrl\":null}]}],\"description\":\"description\",\"title\":\"title\"},\"distribution\":{\"linkedInDistributionTarget\":{}},\"text\":{\"text\":\"text\"}}"
        body = payload.new(default_attrs)

        result = body.to_json

        expect(result).to eq(expected_response)
      end
    end

    context "when description and thumbnail are given" do
      it "responds successfully with a JSON object" do
        default_attrs.merge!(description: "description")
        default_attrs.merge!(thumbnail: "thumbnail")
        expected_response = "{\"owner\":\"urn:li:entity:identifier\",\"content\":{\"contentEntities\":[{\"entityLocation\":\"url\",\"thumbnails\":[{\"resolvedUrl\":\"thumbnail\"}]}],\"description\":\"description\"},\"distribution\":{\"linkedInDistributionTarget\":{}},\"text\":{\"text\":\"text\"}}"
        body = payload.new(default_attrs)

        result = body.to_json

        expect(result).to eq(expected_response)
      end
    end

    context "when title and thumbnail are given" do
      it "responds successfully with a JSON object" do
        default_attrs.merge!(title: "title")
        default_attrs.merge!(thumbnail: "thumbnail")
        expected_response = "{\"owner\":\"urn:li:entity:identifier\",\"content\":{\"contentEntities\":[{\"entityLocation\":\"url\",\"thumbnails\":[{\"resolvedUrl\":\"thumbnail\"}]}],\"title\":\"title\"},\"distribution\":{\"linkedInDistributionTarget\":{}},\"text\":{\"text\":\"text\"}}"
        body = payload.new(default_attrs)

        result = body.to_json

        expect(result).to eq(expected_response)
      end
    end

    context "when title, description, and thumbnail are given" do
      it "responds successfully with a JSON object" do
        default_attrs.merge!(title: "title")
        default_attrs.merge!(description: "description")
        default_attrs.merge!(thumbnail: "thumbnail")
        expected_response = "{\"owner\":\"urn:li:entity:identifier\",\"content\":{\"contentEntities\":[{\"entityLocation\":\"url\",\"thumbnails\":[{\"resolvedUrl\":\"thumbnail\"}]}],\"description\":\"description\",\"title\":\"title\"},\"distribution\":{\"linkedInDistributionTarget\":{}},\"text\":{\"text\":\"text\"}}"
        body = payload.new(default_attrs)

        result = body.to_json

        expect(result).to eq(expected_response)
      end
    end
  end
end
