require 'logger'

module XClarityClient
  class << self
    attr_writer :logger

    def logger
      @logger ||= ::Logger.new(IO::NULL)
    end
  end
end
