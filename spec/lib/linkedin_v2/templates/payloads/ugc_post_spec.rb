require "spec_helper"

describe LinkedinV2::Templates::Payloads::UgcPost do
  subject(:payload) { described_class }
  let(:default_attrs) do
    { entity: "entity", identifier: "identifier", text: "text" }
  end

  describe "#to_json" do
    context "when entity parameter is given" do
      it "responds successfully with a JSON object" do
        expected_response = "{\"author\":\"urn:li:entity:identifier\",\"lifecycleState\":\"PUBLISHED\",\"specificContent\":{\"com.linkedin.ugc.ShareContent\":{\"shareCommentary\":{\"text\":\"text\"},\"shareMediaCategory\":\"NONE\"}},\"visibility\":{\"com.linkedin.ugc.MemberNetworkVisibility\":\"PUBLIC\"}}"
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
        expected_response = "{\"author\":\"urn:li:entity:identifier\",\"lifecycleState\":\"PUBLISHED\",\"specificContent\":{\"com.linkedin.ugc.ShareContent\":{\"shareCommentary\":{\"text\":\"text\"},\"shareMediaCategory\":\"NONE\"}},\"visibility\":{\"com.linkedin.ugc.MemberNetworkVisibility\":\"PUBLIC\"}}"
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

    context "when identifier parameter is given" do
      it "responds successfully with a JSON object" do
        expected_response = "{\"author\":\"urn:li:entity:identifier\",\"lifecycleState\":\"PUBLISHED\",\"specificContent\":{\"com.linkedin.ugc.ShareContent\":{\"shareCommentary\":{\"text\":\"text\"},\"shareMediaCategory\":\"NONE\"}},\"visibility\":{\"com.linkedin.ugc.MemberNetworkVisibility\":\"PUBLIC\"}}"
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

    context "when picture_url parameter is given" do
      it "responds successfully with a JSON object" do
        default_attrs.merge!(picture_url: "picture_url")
        expected_response = "{\"author\":\"urn:li:entity:identifier\",\"lifecycleState\":\"PUBLISHED\",\"specificContent\":{\"com.linkedin.ugc.ShareContent\":{\"shareCommentary\":{\"text\":\"text\"},\"shareMediaCategory\":\"NONE\"}},\"visibility\":{\"com.linkedin.ugc.MemberNetworkVisibility\":\"PUBLIC\"}}"
        body = payload.new(default_attrs)

        result = body.to_json

        expect(result).to eq(expected_response)
      end
    end

    context "when picture_url parameter is not given" do
      it "responds successfully with a JSON object" do
        expected_response = "{\"author\":\"urn:li:entity:identifier\",\"lifecycleState\":\"PUBLISHED\",\"specificContent\":{\"com.linkedin.ugc.ShareContent\":{\"shareCommentary\":{\"text\":\"text\"},\"shareMediaCategory\":\"NONE\"}},\"visibility\":{\"com.linkedin.ugc.MemberNetworkVisibility\":\"PUBLIC\"}}"
        body = payload.new(default_attrs)

        result = body.to_json

        expect(result).to eq(expected_response)
      end
    end
  end
end
