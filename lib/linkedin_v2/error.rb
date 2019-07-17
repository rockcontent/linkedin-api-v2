module LinkedinV2
  class Error < StandardError
    attr_reader :details

    def initialize(msg = "", details:)
      @details = details
      super(msg)
    end
  end

  # Url Builder error
  InvalidEndpointError = Class.new(Error)

  # LinkedIn response error
  LinkedinResponseError = Class.new(Error)
end
