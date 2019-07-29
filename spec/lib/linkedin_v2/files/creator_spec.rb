require "spec_helper"

describe LinkedinV2::Files::Reader do
  subject(:reader) { described_class }

  describe ".call" do
    it "returns a File object" do
      path = "/path"
      file_mocked = double("file")
      allow(File).to receive(:join).and_return(path)
      allow(File).to receive(:read).with(path).and_return(file_mocked)

      result = reader.(path)

      expect(result).to eq(file_mocked)
    end
  end
end
