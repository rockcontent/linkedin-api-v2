require "spec_helper"

describe LinkedinV2::Files::Creator do
  subject(:creator) { described_class }

  describe ".call" do
    it "returns a File object" do
      picture_url = "http://www.rockcontent.com/img.jpg"
      path = "/path"
      tempfile_mocked = double("tempfile", path: path)
      file_mocked = double("file")
      filename = "img.jpg"
      allow(Down).to receive(:download).with(picture_url).and_return(tempfile_mocked)
      allow(File).to receive(:basename).with(path).and_return(filename)
      allow(FileUtils).to receive(:mv).with(path, "tmp/#{filename}").and_return(true)
      allow(File).to receive(:new).with("tmp/#{filename}").and_return(file_mocked)

      result = creator.(picture_url)

      expect(result).to eq(file_mocked)
    end
  end
end
