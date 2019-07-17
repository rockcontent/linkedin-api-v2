module LinkedinV2
  module Files
    class Creator
      # picture_url: Image URL (png or jpeg) to send to LinkedIn
      def self.call(picture_url)
        tempfile = Down.download(picture_url)
        tempfile_path = tempfile.path
        filename = File.basename(tempfile_path)
        FileUtils.mv(tempfile_path, "tmp/#{filename}")

        File.new("tmp/#{filename}")
      end
    end
  end
end
