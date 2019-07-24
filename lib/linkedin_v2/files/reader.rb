module LinkedinV2
  module Files
    class Reader
      def self.call(name)
        template_path = File.join(
          File.dirname(__FILE__),
          "../templates/endpoints/#{name}.erb"
        )

        File.read(template_path)
      end
    end
  end
end
