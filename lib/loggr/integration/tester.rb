module Loggr
  module Integration
    class LoggrTestException <StandardError;
    end

    def self.test
      begin
        raise LoggrTestException.new, 'Test exception'
      rescue Exception => e
        unless Loggr::Remote.error(Loggr::ExceptionData.new(e, "Test Exception"))
          puts "Problem sending exception to Loggr. Check your API key."
        else
          puts "Test Exception sent. Please login to http://loggr.net to see it!"
        end
      end
    end
  end
end


