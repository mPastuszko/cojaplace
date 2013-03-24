module App
  module Helpers
    def today
      Time.now.strftime("%D")
    end
  end
end