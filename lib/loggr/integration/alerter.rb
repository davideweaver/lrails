module Loggr
  class Alert <StandardError;
  end

  module Integration
    def self.alert(msg, env={})
      return Loggr::Remote.error(Loggr::AlertData.new(Alert.new(msg), "Alert"))
    end
  end
end

