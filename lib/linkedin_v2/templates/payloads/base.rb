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

        protected

        def deep_merge(first, second)
          merger = proc { |_key, element1, element2|
            if Hash === element1 && Hash === element2
              element1.merge(element2, &merger)
            else
              if Array === element1 && Array === element2
                element1 | element2
              else
                [ :undefined, nil, :nil ].include?(element2) ? element1 : element2
              end
            end
          }

          first.merge(second.to_h, &merger)
        end

        private

        attr_reader :options
      end
    end
  end
end
