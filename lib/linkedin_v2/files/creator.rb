module LinkedinV2
  module Files
    class Creator
      # picture_url: Image URL (png or jpeg) to send to LinkedIn
      def self.call(picture_url)
        tempfile = Down.download(picture_url)

        File.new(tempfile.path)
      end
    end
  end
end
