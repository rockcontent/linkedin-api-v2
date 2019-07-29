module LinkedinV2
  module Url
    module Response
      TEMPLATE_PATH = "../templates/endpoints/".freeze

      class << self
        def [](name, **options)
          path = TEMPLATE_PATH + "#{name}.erb"
          file = Files::Reader.(path)
          erb = ERB.new(file)

          options.empty? ? erb.result : erb.result_with_hash(options)
        end
      end
    end
  end
end
