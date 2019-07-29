module LinkedinV2
  module Helpers
    module Attribute
      class << self
        def present?(attr)
          !attr.to_s.strip.empty?
        end
      end
    end
  end
end
