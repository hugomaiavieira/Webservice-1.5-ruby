module Cielo
  class IntegrationError < StandardError
    attr_reader :code, :body

    def initialize(args = {})
      @code = args[:code]
      @body = args[:body]
      super("Cielo raises an integration error with code #{code}")
    end
  end
end
