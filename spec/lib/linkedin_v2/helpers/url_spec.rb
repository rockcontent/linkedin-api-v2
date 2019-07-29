require "spec_helper"

describe LinkedinV2::Helpers::Url do
  subject(:helper) { described_class }

  describe ".escape" do
    it "returns a hash with all values encoded" do
      params = { foo: "(elements*(original))" }

      result = helper.escape(params)

      expect(result).to be_a(Hash)
      expect(result).to eq({ foo: "%28elements%2A%28original%29%29" })
    end
  end
end
