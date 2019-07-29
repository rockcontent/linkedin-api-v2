require "spec_helper"
require "linkedin_v2/files/reader"


describe LinkedinV2::Url::Response do
  subject(:response) { described_class }

  describe ".[]" do
    context "when options is not given" do
      it "builds correctly response" do
        endpoint = "/endpoint"
        mock_template_file = double("template_file")
        mock_erb_file = double("erb_file", result: endpoint)
        allow(LinkedinV2::Files::Reader).to receive(:call).and_return(mock_template_file)
        allow(ERB).to receive(:new).and_return(mock_erb_file)

        result = LinkedinV2::Url::Response["file"]

        expect(result).to eq(endpoint)
      end
    end

    context "when options is given" do
      it "builds correctly response" do
        options = { projection: "projection" }
        endpoint = "/endpoint"
        mock_template_file = double("template_file")
        mock_erb_file = double("erb_file", result_with_hash: endpoint)
        allow(LinkedinV2::Files::Reader).to receive(:call).and_return(mock_template_file)
        allow(ERB).to receive(:new).and_return(mock_erb_file)

        result = LinkedinV2::Url::Response["file", options]

        expect(result).to eq(endpoint)
      end
    end
  end
end
