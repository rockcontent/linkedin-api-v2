module LinkedinV2
  module Files
    class Reader
      def self.call(path)
        template_path = File.join(File.dirname(__FILE__), path)

        File.read(template_path)
      end
    end
  end
end
