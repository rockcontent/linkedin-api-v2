module LinkedinV2
  module Files
    class Destroyer
      # file: File object
      def self.call(file)
        path_to_file = file.path

        File.delete(path_to_file) if File.exist?(path_to_file.to_s)
      end
    end
  end
end
