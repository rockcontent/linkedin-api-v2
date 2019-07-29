require "spec_helper"

describe LinkedinV2::Files::Destroyer do
  subject(:destroyer) { described_class }

  describe ".call" do
    context "when file exists" do
      it "calls Files.delete" do
        path = "/tmp/img.jpg"
        file = double("file", path: path)
        allow(File).to receive(:exist?).with(path).and_return(true)
        allow(File).to receive(:delete).with(path).and_return(true)

        destroyer.(file)

        expect(File).to have_received(:delete).with(path)
      end
    end

    context "when file does not exist" do
      it "does not call Files.delete" do
        path = "/tmp/img.jpg"
        file = double("file", path: path)
        allow(File).to receive(:exist?).with(path).and_return(false)
        allow(File).to receive(:delete).with(path).and_return(true)

        destroyer.(file)

        expect(File).not_to have_received(:delete)
      end
    end
  end
end
