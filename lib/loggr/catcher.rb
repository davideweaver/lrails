module Loggr
  class Catcher
    class << self
      def handle_with_controller(exception, controller=nil, request=nil)
        if Config.should_send_to_api?
		  Loggr::Events.create_from_exception(exception).post()
        end
      end
      
      def handle_with_rack(exception, environment, request) 
        if Config.should_send_to_api?
          # data = RackExceptionData.new(exception, environment, request)
		  Loggr::Events.create_from_exception(exception).post()
        end
      end

      def handle(exception, name=nil)
        if Config.should_send_to_api?
          Loggr::Events.create_from_exception(exception).post()
        end
      end
    end
  end
end
