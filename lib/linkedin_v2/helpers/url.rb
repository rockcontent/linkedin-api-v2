module LinkedinV2
  module Helpers
    module Url
      class << self
        # Escapes parameters hash on first level
        def escape(**params)
          params.inject({}) do |hash, (key, value)|
            hash[key] = CGI::escape(value.to_s)
            hash
          end
        end
      end
    end
  end
end
