module LinkedinV2
  module Templates
    module Payloads
      class Base
        def initialize(**options)
          @options = options
        end

        def to_json
          raise NotImplementedError
        end

        private

        attr_reader :options
      end
    end
  end
end
