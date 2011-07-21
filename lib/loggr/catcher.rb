module Loggr
  class Catcher
    class << self
      def handle_with_controller(exception, controller=nil, request=nil)
        if Config.should_send_to_api?
          data = ControllerExceptionData.new(exception, controller, request)
		  Loggr::Events.create().text("handle_with_controller").data(data).post()
        end
      end
      
      def handle_with_rack(exception, environment, request) 
        if Config.should_send_to_api?
          data = RackExceptionData.new(exception, environment, request)
		  Loggr::Events.create().text("handle_with_rack").data(data).post()
        end
      end

      def handle(exception, name=nil)
        if Config.should_send_to_api?
          data = ExceptionData.new(exception, name)
		  Loggr::Events.create().text("handle").data(data).post()
        end
      end
    end
  end
end
